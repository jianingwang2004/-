`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/29 18:10:16
// Design Name: 
// Module Name: Comp_4
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


module Comp_4(
    input [ 31 : 0] a, b,
    output [ 0 : 0] ul,
    output [ 0 : 0] sl
);

wire [ 31 : 0]A;
wire x;
assign A = a - b;
assign sl = ((a[31] ~^ b[31]) & A[31]) | ((a[31] ^ b[31]) & a[31]);
assign ul = (a < b) ? 1'b1 : 1'b0;

endmodule
