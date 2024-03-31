`timescale 1ns / 1ps

module whack_a_mole_top(
    //input clk,  
    //input reset,
    //Doing a test case// input [7:0] btn,  // my 8 buttons
    output [7:0] led  // 4 LEDs representing the moles
);
//TESTCASE BELOW
reg [3:0] btn;
initial begin
    btn = 1;
    #2
    btn = 6;
    #2
    btn = 4;
end
//TESTCASE ABOVE

//im creating the clk bruh
reg clk=1;
always begin
    #2;
    clk = ~clk;
end

//im creating the reset bruh
reg reset=0;
initial begin
    #4;
    reset=1;
    #4;
    reset=0;
end

// Instances of debounce modules for each button
wire [7:0] debounced_btn;
generate
    genvar i;
    for (i = 0; i < 8; i = i + 1) begin : debounce_instance
        debounce db_inst(.clk(clk), .btn_in(btn[i]), .btn_out(debounced_btn[i]));
    end
endgenerate

// RNG instance
wire [7:0] mole_position;
rng rng_inst(.clk(clk), .reset(reset), .random_number(mole_position));

// Game logic and LED control (simplified example)
assign led = mole_position;

initial begin
    #100;
    $finish();
end
endmodule
