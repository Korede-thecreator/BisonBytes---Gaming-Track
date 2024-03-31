// VGA driver module for Whack-A-Mole FPGA game
// BisonBytes hackathon
// 3/31/2024

// Count the horizontal lines (800 total)
module horizontal_counter(
    input clk,
    input rst,
    output reg [10:0] horizontal_count,
    output horiz_count_out;
    );

    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            horizontal_count <= 0;
            horiz_count_out <= 1'b0;
        end else begin
            if (horizontal_count < 800) begin
                horizontal_count <= horizontal_count + 1;
                horiz_count_out <= 1'b0;
            end else begin
                horizontal_count <= 0;
                horiz_count_out <= 1'b1;
            end
        end
    end
endmodule

// Count the vertical lines (525 total)
module vertical_counter(
    input clk,
    input rst,
    output reg [10:0] vertical_count,
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

// Module to output VGA signal based on counter values
module VGA_Driver(
    input clk,
    input rst,
    output [2:0] red_pin,
    output [2:0] green_pin,
    output [1:0] blue_pin,
    output horizontal_sync,
    output vertical_sync;
    );

    wire [10:0] h_count;
    wire [10:0] v_count;
    wire vertical_count_enable; // Goes high to count up to the next vertical line after each horizontal line has been scanned

    // Create our counters and connect them
    horizontal_counter h_counter(
        .clk(clk),
        .rst(rst),
        .horizontal_count(h_count[10:0]),
        .horiz_count_out(vertical_count_enable)
        );

    vertical_counter v_counter(
        .clk(vertical_count_enable),
        .rst(rst),
        .vertical_count(v_count)
        );

    // Horizontal/Vertical sync signals
    if (h_count < 96)
        assign horizontal_sync = 1'b1;
    else
        assign horizontal_sync = 1'b0;

    if (v_count < 2)
        assign vertical_sync = 1'b1;
    else
        assign vertical_sync = 1'b0;

    // Color signals
    // Red
    if (h_count > 143 && h_count < 784 && v_count > 35 && v_count < 515)
        assign red_pin = 3'b000;

    // Green
    if (h_count > 143 && h_count < 784 && v_count > 35 && v_count < 515)
        assign green_pin = 3'b000;

    // Blue
    if (h_count > 143 && h_count < 784 && v_count > 35 && v_count < 515)
        assign blue_pin = 2'b11;

endmodule