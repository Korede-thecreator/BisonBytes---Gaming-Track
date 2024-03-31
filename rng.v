`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2024 02:33:14 AM
// Design Name: 
// Module Name: rng
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module rng(
    input clk,
    input reset,
    output reg [7:0] random_number
);
//this is just a simple note to explainw hat ti sgoing o but I fw e can  we can do it then we ca 
//first and
always @(posedge clk or posedge reset) begin
    if (reset) begin
        random_number <= 8'b10101010;  // Example initial seed 
    end else begin
        // Simple Linear Feedback Shift Register (LFSR) for randomness
        random_number <= {random_number[2:0], random_number[3] ^ random_number[2]};
    end
end

endmodule
