`timescale 1ns / 1ps

module tb_RandomNumber;

reg clk = 0;
reg reset = 0;
wire [7:0] random_number;

// Instantiate the RandomNumber module
RandomNumber uut (
    .clk(clk),
    .reset(reset),
    .random_number(random_number)
);

// Clock generation
always #5 clk = ~clk; // 100 MHz clock

// Test sequence
initial begin
    reset = 1; #10;
    reset = 0; #20; // Release reset
    
    // Observe changes in random_number across several clock cycles
    // No further input is required; just monitor the output
    
    #1000; // Run simulation for enough time to see several updates
    
    $finish; // End simulation
end

endmodule

