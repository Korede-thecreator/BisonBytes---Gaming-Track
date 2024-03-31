`timescale 1ns / 1ps

module tb_rng;

reg clk;
reg reset;
wire [7:0] random_number;

// Instantiate the RNG module
rng uut (
    .clk(clk),
    .reset(reset),
    .random_number(random_number)
);

// Clock generation
initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

// Test sequence
initial begin
    reset = 1; #20;
    reset = 0; #100;

    // Observe random_number changes over time
    // No direct interaction after reset, just observe the output

    $finish;
end

endmodule
