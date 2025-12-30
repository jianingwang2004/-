
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/08 08:18:26
// Design Name: 
// Module Name: PC
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


module PC(
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,
    input                   [ 0 : 0]             en,
    input                   [31 : 0]            npc,
    input                   [ 0 : 0]          flush,
    input                   [ 0 : 0]          stall,
    output      reg         [31 : 0]             pc
    );
    
    always @(posedge clk) begin
        if(rst)     pc <= 32'h1c00_0000;
        else begin
            if(en) begin
            	if(flush) pc <= 32'h1c00_0000;
            	else if(!stall)      pc <= npc;
            end
        end
    end
endmodule
