`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/27 18:12:12
// Design Name: 
// Module Name: ALU_tb
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


module top_tb1();
reg clk,rst,enable;
reg [4:0] in;
reg [1:0] ctrl;
wire [3:0] seg_data;
wire [2:0] seg_an;
initial begin
    clk = 0;
    rst = 1;
    enable = 0;
    #10;
    rst = 0;
    ctrl = 2'b00;
    in[4:0] = 5'b000000;//¼Ó·¨
    #20;
    enable = 1;
    #10;
    enable = 0;
    ctrl = 2'b01;
    in[4:0] = 5'b00001;
    #20;
    enable = 1;
    #10;
    enable = 0;
    ctrl = 2'b10;
    in[4:0] = 5'b00010;
    #20;
    enable = 1;
    #10;
    enable = 0;
    ctrl = 2'b11;
    #10;
    enable = 1;
end
always #5 clk = ~clk;
TOP top(
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .in(in),
    .ctrl(ctrl),
    .seg_data(seg_data),
    .seg_an(seg_an)
);

endmodule
/*module TOP (
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,

    input                   [ 0 : 0]            enable,
    input                   [ 4 : 0]            in,
    input                   [ 1 : 0]            ctrl,

    output                  [ 3 : 0]            seg_data,
    output                  [ 2 : 0]            seg_an
);*/