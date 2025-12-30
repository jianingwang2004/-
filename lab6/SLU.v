
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/15 09:39:31
// Design Name: 
// Module Name: SLU
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


module SLU (
    input                   [31 : 0]                addr,
    input                   [ 3 : 0]                dmem_access,

    input                   [31 : 0]                rd_in,
    input                   [31 : 0]                wd_in,

    output      reg         [31 : 0]                rd_out,
    output      reg         [31 : 0]                wd_out
);

always @(*) begin
    case(dmem_access)
        4'b0001: begin
        	 rd_out = rd_in; 
        	 wd_out = 0;
        	 end
        4'b0010: begin
        	 rd_out = addr[1] ? {{16{rd_in[31]}},rd_in[31:16]} : {{16{rd_in[15]}},rd_in[15:0]}; 
        	 wd_out = 0; 
        	 end
        4'b0011: begin 
        	 rd_out = addr[1] ? (addr[0] ? {{24{rd_in[31]}},rd_in[31:24]} : {{24{rd_in[23]}},rd_in[23:16]}) : (addr[0] ? {{24{rd_in[15]}},rd_in[15:8]} : {{24{rd_in[7]}},rd_in[7:0]}); 
        	 wd_out = 0; 
        	 end
        4'b0100: begin 
        	 rd_out = addr[1] ? {16'b0,rd_in[31:16]} : {16'b0,rd_in[15:0]}; 
        	 wd_out = 0; 
        	 end
        4'b0101: begin 
        	 rd_out = addr[1] ? (addr[0] ? {24'b0,rd_in[31:24]} : {24'b0,rd_in[23:16]}) : (addr[0] ? {24'b0,rd_in[15:8]} : {24'b0,rd_in[7:0]}); 
        	 wd_out = 0; 
        	 end
        4'b0110: begin 
        	 rd_out = 0; 
        	 wd_out = wd_in; 
        	 end
        4'b0111: begin 
        	 rd_out = 0; 
        	 wd_out = addr[1] ? {wd_in[15:0],rd_in[15:0]} : {rd_in[31:16],wd_in[15:0]}; 
        	 end
        4'b1000: begin 
        	 rd_out = 0; 
        	 wd_out = addr[1] ? (addr[0] ? {wd_in[7:0],rd_in[23:0]} : {rd_in[31:24],wd_in[7:0],rd_in[15:0]}) : (addr[0] ? {rd_in[31:16],wd_in[7:0],rd_in[7:0]} : {rd_in[31:8],wd_in[7:0]}); 
        	 end
        default: begin 
        	 rd_out = 0;
        	 wd_out = 0;
        	 end
    endcase
end

endmodule
