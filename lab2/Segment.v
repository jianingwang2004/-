`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/30 11:12:32
// Design Name: 
// Module Name: Segment
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


module Segment(
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,
    input                   [31 : 0]            output_data,
    output          reg     [ 3 : 0]            seg_data,
    output          reg     [ 2 : 0]            seg_an
);

parameter COUNT_NUM = 50_000_000 / 400;         // 100MHz to 400Hz
parameter SEG_NUM = 8;                          // Number of segments

reg [31:0] counter;
always @(posedge clk) begin
    if (rst)
        counter <= 0;
    else if (counter >= COUNT_NUM)
        counter <= 0;
    else
        counter <= counter + 1;
end

reg [2:0] seg_id;
always @(posedge clk) begin
    if (rst)
        seg_id <= 0;
    else if (counter == COUNT_NUM) begin
        if (seg_id >= SEG_NUM - 1)
            seg_id <= 0;
        else
            seg_id <= seg_id + 1;
    end
end

always @(*) begin
    seg_data = 0;
    case (seg_an)
        3'd0     : seg_data = output_data[3:0]; 
        3'd1     : seg_data = output_data[7:4];
        3'd2     : seg_data = output_data[11:8];
        3'd3     : seg_data = output_data[15:12];
        3'd4     : seg_data = output_data[19:16];
        3'd5     : seg_data = output_data[23:20];
        3'd6     : seg_data = output_data[27:24];
        3'd7     : seg_data = output_data[31:28];
        default : seg_data = 0;
    endcase
end

always @(*) begin
    seg_an = seg_id;
end
endmodule
