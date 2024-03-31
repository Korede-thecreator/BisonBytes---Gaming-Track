

module debounce(
    input clk,  // Clock input
    input btn_in,  // Button input from the FPGA
    output reg btn_out  // Debounced button output
);

reg [15:0] counter;  // Counter for debounce time
reg btn_state;  // Current stable state of the button

always @(posedge clk) begin
    if (btn_in == btn_state) begin
        // Reset counter if button state is stable
        counter <= 0;
    end else begin
        // Increment counter if button state is changing
        counter <= counter + 1;
        // Update button state and output if counter exceeds threshold
        if (counter >= 16'b1111111111111111) begin
            btn_state <= btn_in;
            btn_out <= btn_in;
            counter <= 0;
        end
    end
end

endmodule
