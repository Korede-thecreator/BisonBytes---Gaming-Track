// Testbench for VGA driver module for Whack-A-Mole FPGA game
// BisonBytes hackathon
// 3/31/2024

module TB_VGA_Driver();
    // Design inputs
    reg clock;
    reg reset;

    // Design outputs
    reg [2:0] red;
    reg [2:0] green;
    reg [1:0] blue;
    reg h_sync;
    reg v_sync;

    // Design under test
    VGA_Driver dut(
        .clk(clock),
        .rst(reset),
        .red_pin(red),
        .green_pin(green),
        .blue_pin(blue),
        .horizontal_sync(h_sync),
        .vertical_sync(v_sync)
    );

    // Generate test stimulus
    initial begin
        // Initialise signals
        clock = 1'b0;
        reset = 1'b1;

        // 20ns to propogate
        #20

        reset = 1'b0;
        #10

        // Generate input
        for (i = 0; i < 3000; i = i + 1) begin
            clock = 1'b0;
            #1
            clock = ~clock;
        end
    end
endmodule