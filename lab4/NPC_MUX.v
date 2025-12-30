`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/15 09:28:46
// Design Name: 
// Module Name: NPC_MUX
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


module NPC_MUX(
    input           [31 : 0] pc_add4,
    input           [31 : 0] pc_offset,
    input           [ 1 : 0] npc_sel,
    output  reg     [31 : 0] npc
    );
    always @(*) begin
        case(npc_sel)
            2'b00 : npc = pc_add4;
            2'b01 : npc = pc_offset;
            default : npc = 32'd0;
        endcase 
    end
endmodule
