
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/08 08:42:13
// Design Name: 
// Module Name: ALU
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




`define     ADD     5'B00000    
`define     SUB     5'B00010   
`define     SLT     5'B00100
`define     SLTU    5'B00101
`define     AND     5'B01001
`define     OR      5'B01010
`define     XOR     5'B01011
`define     SLL     5'B01110   
`define     SRL     5'B01111    
`define     SRA     5'B10000  
`define     SRC0    5'B10001
`define     SRC1    5'B10010

module ALU(
    input   [31 : 0] alu_src0, 
    input   [31 : 0] alu_src1,
    input   [ 4 : 0] alu_op,
    output  reg [31 : 0] alu_res
);

wire [31:0] add_out;
wire [31:0] sub_out;
wire [0 :0] slt_out;
wire [0 :0] sltu_out;

Comp_4 comp(
    .a(alu_src0),
    .b(alu_src1),
    .ul(sltu_out),
    .sl(slt_out)
);

always @(*) begin
    case(alu_op)
        `ADD :
            alu_res = alu_src0 + alu_src1;
        `SUB :   
            alu_res = alu_src0 - alu_src1;
        `SLT :
            alu_res = {31'd0 , slt_out};
        `SLTU:
            alu_res = {31'd0 , sltu_out};
        `AND :
            alu_res = alu_src0 & alu_src1;
        `OR  :
            alu_res = alu_src0 | alu_src1;
        `XOR :
            alu_res = alu_src0 ^ alu_src1;
        `SLL :   
            alu_res = alu_src0 << alu_src1[4:0];
        `SRL :    
            alu_res = alu_src0 >> alu_src1[4:0];
        `SRA :  
            alu_res = $signed(alu_src0) >>> alu_src1[4:0];
        `SRC0:
            alu_res = alu_src0;
        `SRC1:
            alu_res = alu_src1;
        default:
            alu_res = 32'H0;
    endcase
end
endmodule    
    
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
