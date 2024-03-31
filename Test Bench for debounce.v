`timescale 1ns / 1ps

module tb_debounce;

reg clk = 0;
reg noisy_signal = 0;
wire debounced_signal;

// Instantiate the debounce module
debounce uut (
    .clk(clk),
    .noisy_signal(noisy_signal),
    .debounced_signal(debounced_signal)
);

// Clock generation
always #5 clk = ~clk; // 100 MHz clock

// Test sequence
initial begin
    // Initial state
    #100; // Wait for any initial conditions to settle
    
    // Simulate a noisy signal
    repeat (5) begin
        noisy_signal = 1; #10;
        noisy_signal = 0; #10;
    end
    
    // Hold signal high to see if it stabilizes
    noisy_signal = 1; #100;
    
    $finish; // End simulation
end

endmodule
