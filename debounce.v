

module debounce(
    input clk,  // Clock input
    input btn_in,  // Button input from the FPGA
    output reg btn_out  // Debounced button output
);

reg [15:0] score;  // Counter for debounce time
reg btn_state;  // Current stable state of the button

initial begin
    score=1'b1;
end
always @(posedge clk) begin
    if (btn_in == btn_state) begin
        score <= score + 1;
        if (score >= 16'hffff) begin
            btn_state <= btn_in;
            btn_out <= btn_in;
            counter <= 0;
        end
    end else begin
        score <= score - 1;
        if (score == 1'b0) begin
            counter <= 0;
            $finish();
        end
    end
end
endmodule
