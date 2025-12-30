`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/30 11:14:44
// Design Name: 
// Module Name: regfile
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


module regfile(
    input                   [ 0 : 0]        clk,
    input                   [ 0 : 0]        rst,
    input                   [ 0 : 0]        rf_we,//写使能
    input                   [31 : 0]        rf_wd,//写数据
    output        reg       [31 : 0]        rf_rd
);

    always @(posedge clk) begin
        if(rst) rf_rd <= 32'd0;
        else if(rf_we) rf_rd <= rf_wd;
    end
    
endmodule
