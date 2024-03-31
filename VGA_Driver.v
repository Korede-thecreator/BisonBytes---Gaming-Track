// VGA driver module for Whack-A-Mole FPGA game
// BisonBytes hackathon
// 3/31/2024

// Count the horizontal lines (800 total)
module horizontal_counter(
    input clk,
    input rst,
    output wire [10:0] horizontal_count,
    output reg horiz_count_out
    );

    reg [10:0] count;

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            horiz_count_out <= 1'b0;
        end else begin
            if (horizontal_count < 800) begin
                count <= count + 1;
                horiz_count_out <= 1'b0;
            end else begin
                count <= 0;
                horiz_count_out <= 1'b1;
            end
        end
    end

    assign horizontal_count = count;
endmodule

// Count the vertical lines (525 total)
module vertical_counter(
    input clk,
    input rst,
    output reg [10:0] vertical_count
    //output vertical_count_out;
    );

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            vertical_count <= 0;
            //vertical_count_out <= 1'b0;
        end else begin
            if (vertical_count < 525) begin
                vertical_count <= vertical_count + 1;
                //vertical_count_out <= 1'b0;
            end else begin
                vertical_count <= 0;
                //vertical_count_out <= 1'b1;
            end
        end
    end
endmodule

// Clock divider
module clock_divider (
    input wire clk_50MHz,
    output reg clk_25MHz
);

reg [24:0] counter;

always @(posedge clk_50MHz) begin
    if (counter == 25'd1_000_000) begin
        clk_25MHz <= ~clk_25MHz; // Toggle the output clock every 1,000,000 cycles
        counter <= 0;
    end
    else begin
        counter <= counter + 1;
    end
end

endmodule

// Module to output VGA signal based on counter values
module VGA_Driver(
    input clk,
    input rst,
    output [2:0] red_pin,
    output [2:0] green_pin,
    output [1:0] blue_pin,
    output reg horizontal_sync,
    output reg vertical_sync
    );

    wire [10:0] h_count;
    wire [10:0] v_count;
    wire vertical_count_enable; // Goes high to count up to the next vertical line after each horizontal line has been scanned
    wire clk_25mhz;

    reg [2:0] red;
    reg [2:0] green;
    reg [1:0] blue;

    // Create clock divider
    clock_divider divider(
        .clk_50MHz(clk),
        .clk_25MHz(clk_25MHz)
    );

    // Create our counters and connect them
    horizontal_counter h_counter(
        .clk(clk_25MHz),
        .rst(rst),
        .horizontal_count(h_count[10:0]),
        .horiz_count_out(vertical_count_enable)
        );

    vertical_counter v_counter(
        .clk(vertical_count_enable),
        .rst(rst),
        .vertical_count(v_count)
        );

    always @ (posedge clk_25MHz or posedge rst) begin
        if (rst) begin
            horizontal_sync <= 1'b0;
            vertical_sync <= 1'b0;
            red <= 3'd0;
            green <= 3'd0;
            blue <= 2'd0;
        end else begin
            // Horizontal/Vertical sync signals
            if (h_count < 96)
                horizontal_sync <= 1'b1;
            else
                horizontal_sync <= 1'b0;

            if (v_count < 2)
                vertical_sync <= 1'b1;
            else
                vertical_sync <= 1'b0;

            // Color signals
            // Red
            if (h_count > 143 && h_count < 784 && v_count > 35 && v_count < 515)
                red <= 3'b000;

            // Green
            if (h_count > 143 && h_count < 784 && v_count > 35 && v_count < 515)
                green <= 3'b000;

            // Blue (display all blue for testing purposes)
            if (h_count > 143 && h_count < 784 && v_count > 35 && v_count < 515)
                blue <= 2'b11;
            end
    end

    assign red_pin = red;
    assign blue_pin = blue;
    assign green_pin = green;

endmodule