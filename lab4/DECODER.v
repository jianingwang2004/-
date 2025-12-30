`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/15 09:38:21
// Design Name: 
// Module Name: DECODER
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


module DECODER (
    input                   [31 : 0]            inst,

    output      reg         [ 4 : 0]            alu_op,

    output                  [ 3 : 0]            dmem_access,

    output      reg         [31 : 0]            imm,

    output                  [ 4 : 0]            rf_ra0,
    output                  [ 4 : 0]            rf_ra1,
    output                  [ 4 : 0]            rf_wa,
    output                  [ 0 : 0]            rf_we,
    output      reg         [ 1 : 0]            rf_wd_sel,

    output                  [ 0 : 0]            alu_src0_sel,
    output                  [ 0 : 0]            alu_src1_sel,

    output                  [ 3 : 0]            br_type
);
endmodule
