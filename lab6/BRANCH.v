
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/15 09:36:48
// Design Name: 
// Module Name: BRANCH
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


module BRANCH(
    input                   [ 3 : 0]            br_type,

    input                   [31 : 0]            br_src0,
    input                   [31 : 0]            br_src1,

    output      reg         [ 1 : 0]            npc_sel
);

always @(*) begin
    case(br_type)
        4'b0011:                                    npc_sel = 2'b01;//jirl
        4'b0100:                                    npc_sel = 2'b01;//b
        4'b0101:                                    npc_sel = 2'b01;//bl
        4'b0110:begin 
                if(br_src0 == br_src1)              npc_sel = 2'b01;
                else                                npc_sel = 2'b00;
                end//beq
        4'b0111:begin
                if(br_src0 != br_src1)              npc_sel = 2'b01;
                else                                npc_sel = 2'b00;
                end//bne
        4'b1000:begin
                if($signed(br_src0) < $signed(br_src1))   npc_sel = 2'b01;
                else                                npc_sel = 2'b00;
                end//blt
        4'b1001:begin
                if($signed(br_src0) >= $signed(br_src1))  npc_sel = 2'b01;
                else                                npc_sel = 2'b00;
                end//bge
        4'b1010:begin
                if(br_src0 < br_src1)               npc_sel = 2'b01;
                else                                npc_sel = 2'b00;
                end//bltu
        4'b1011:begin
                if(br_src0 >= br_src1)              npc_sel = 2'b01;
                else                                npc_sel = 2'b00;
                end//bgeu
        default:                                    npc_sel = 2'b00;
    endcase
end

endmodule
