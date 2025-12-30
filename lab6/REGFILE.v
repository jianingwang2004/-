
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/08 08:26:57
// Design Name: 
// Module Name: REGFILE
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


module REGFILE(
    input                   [ 0 : 0]        clk,

    input                   [ 4 : 0]        rf_ra0,
    input                   [ 4 : 0]        rf_ra1,
    input                   [ 4 : 0]        dbg_reg_ra, 
    input                   [ 4 : 0]        rf_wa,
    input                   [ 0 : 0]        rf_we,
    input                   [31 : 0]        rf_wd,

    output        reg       [31 : 0]        rf_rd0,
    output        reg       [31 : 0]        rf_rd1,
    output        reg       [31 : 0]        dbg_reg_rd
);

    reg [31 : 0] reg_file [0 : 31];

    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1)
            reg_file[i] = 0;
    end

    always @(posedge clk) begin
        if(rf_we && rf_wa != 0) begin
            reg_file[rf_wa] <= rf_wd;
        end
    end
    always @(*)begin
    	if(rf_we && rf_ra0 == rf_wa)begin
    		rf_rd0 = (rf_wa == 0) ? 32'd0 : rf_wd;
    	end
    	else begin
    		rf_rd0 = reg_file[rf_ra0];
    	end
    end
    always @(*)begin
    	if(rf_we && rf_ra1 == rf_wa)begin
    		rf_rd1 = (rf_wa == 0) ? 32'd0 : rf_wd;
    	end
    	else begin
    		rf_rd1 = reg_file[rf_ra1];
    	end
    end
    always @(*) begin
    	dbg_reg_rd = reg_file[dbg_reg_ra];
    end
endmodule
