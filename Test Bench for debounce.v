`timescale 1ns / 1ps

module tb_debounce;

reg clk;
reg noisy_signal;
wire debounced_signal;

// Instantiate the debounce module
debounce uut (
    .clk(clk),
    .noisy_signal(noisy_signal),
    .debounced_signal(debounced_signal)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test sequence
initial begin
    noisy_signal = 0;
    #100;
    
    // Simulate a noisy signal edge
    noisy_signal = 1; #20;
    noisy_signal = 0; #20;
    noisy_signal = 1; #20;

    // Continue to simulate more edge cases as needed

    $finish;
end

endmodule
