`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/29 18:08:55
// Design Name: 
// Module Name: AddSub
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


module AddSub(
    input [ 31 : 0] a, b,
    output [ 31 : 0] out,
    output [ 0 : 0] co
);

Adder4_32 fa1(
    .a(a),
    .b(~b),
    .ci(1'B1),
    .s(out),
    .co(co)
);

endmodule
