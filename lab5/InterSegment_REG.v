module Intersegment_REG (
    input     		[ 0 : 0]        clk		,
    input     		[ 0 : 0]        rst		,
    input     		[ 0 : 0]        en		,
    input     		[ 0 : 0]        stall		,
    input     		[ 0 : 0]        flush		,
  
    //IF/ID  
    input            	[31 : 0]        pcadd4_in	,
    output	reg	[31 : 0]        pcadd4_out	,
    input            	[31 : 0]        pc_in		,
    output    	reg    	[31 : 0]        pc_out		,
    input            	[31 : 0]        inst_in		,
    output    	reg    	[31 : 0]        inst_out	,
    input            	[ 0 : 0]        commit_in	,
    output    	reg    	[ 0 : 0]        commit_out	,
  
    //ID/EX  
    input            	[31 : 0]        imm_in		,
    output    	reg    	[31 : 0]        imm_out		,
    input            	[ 4 : 0]        rf_wa_in	,
    output    	reg     [ 4 : 0]        rf_wa_out	,
    input            	[31 : 0]        rf_rd0_in	,
    output    	reg     [31 : 0]        rf_rd0_out	,
    input           	[31 : 0]        rf_rd1_in	,
    output    	reg     [31 : 0]        rf_rd1_out	,
    input           	[ 0 : 0]        rf_we_in	,
    output    	reg     [ 0 : 0]        rf_we_out	,
    input            	[ 1 : 0]        rf_wd_sel_in	,
    output    	reg     [ 1 : 0]        rf_wd_sel_out	,
    input            	[ 4 : 0]        alu_op_in	,
    output    	reg     [ 4 : 0]        alu_op_out	,
    input            	[ 0 : 0]        alu_src0_sel_in	,
    output    	reg     [ 0 : 0]        alu_src0_sel_out,
    input            	[ 0 : 0]        alu_src1_sel_in	,
    output    	reg    	[ 0 : 0]        alu_src1_sel_out,
    input           	[ 3 : 0]        dmem_access_in	,
    output    	reg    	[ 3 : 0]        dmem_access_out	,
    input         	[ 3 : 0]        br_type_in	,
    output    	reg    	[ 3 : 0]        br_type_out	,
    input         	[ 0 : 0]        dmem_we_in	,
    output    	reg    	[ 0 : 0]        dmem_we_out	,

    //EX/MEM  
    input            	[31 : 0]        alu_res_in	,
    output    	reg    	[31 : 0]        alu_res_out	,

    //MEM/WB         
    input            	[31 : 0]        dmem_rd_out_in	,
    output    	reg    	[31 : 0]        dmem_rd_out_out	,
    input            	[31 : 0]        dmem_wdata_in	,
    output    	reg    	[31 : 0]        dmem_wdata_out
);

always @(posedge clk) begin
    if (rst) begin
        // rst 操作的逻辑
        pcadd4_out         	<= 	32'h1c00_0004	;
        pc_out             	<= 	32'h1c00_0000	;
        inst_out           	<=	32'h0		;
        rf_rd0_out         	<= 	32'h0		;
        rf_rd1_out         	<= 	32'h0		;
        imm_out            	<= 	32'h0		;
        rf_wa_out          	<= 	 5'h0		;
        rf_we_out          	<= 	 1'h0		;
        rf_wd_sel_out     	<= 	 2'h0		;
        alu_op_out         	<= 	 5'h0	        ;
        alu_src0_sel_out   	<= 	 1'h0		;
        alu_src1_sel_out   	<= 	 1'h0		;
        dmem_access_out    	<= 	 4'h0	        ;
        br_type_out        	<= 	 4'h0	        ;
        alu_res_out        	<= 	32'h0		;
        dmem_rd_out_out    	<= 	32'h0		;
        dmem_we_out        	<= 	 1'h0		;
        commit_out         	<= 	 1'h0		;
        dmem_wdata_out     	<= 	32'h0		;
    end
    else if (en) begin
        // flush 和 stall 操作的逻辑, flush 的优先级更高
        if (flush) begin
            pcadd4_out         	<= 	32'h1c00_0004	;
            pc_out             	<= 	32'h1c00_0000	;
            inst_out           	<= 	32'h0000_0000	;
            rf_rd0_out         	<= 	32'h0		;
            rf_rd1_out         	<= 	32'h0		;
            imm_out            	<= 	32'h0		;
            rf_wa_out          	<= 	 5'h0		;
            rf_we_out          	<= 	 1'h0		;
            rf_wd_sel_out      	<= 	 2'h0		;
            alu_op_out         	<= 	 5'h0	        ;
            alu_src0_sel_out   	<= 	 1'h0		;
            alu_src1_sel_out   	<= 	 1'h0		;
            dmem_access_out    	<= 	 4'h0	        ;
            br_type_out        	<= 	 4'h0	        ;
            alu_res_out        	<= 	32'h0		;
            dmem_rd_out_out    	<= 	32'h0		;
            dmem_we_out        	<= 	 1'h0		;
            commit_out         	<= 	 1'h0		;
            dmem_wdata_out     	<= 	32'h0		;
        end
        else if (!stall) begin
            pcadd4_out         	<= 	pcadd4_in	;
            pc_out             	<= 	pc_in		;
            inst_out           	<= 	inst_in		;
            rf_rd0_out         	<= 	rf_rd0_in	;
            rf_rd1_out         	<= 	rf_rd1_in	;
            imm_out            	<= 	imm_in		;
            rf_wa_out          	<= 	rf_wa_in	;
            rf_we_out          	<= 	rf_we_in	;
            rf_wd_sel_out      	<= 	rf_wd_sel_in	;
            alu_op_out         	<= 	alu_op_in	;
            alu_src0_sel_out   	<= 	alu_src0_sel_in	;
            alu_src1_sel_out   	<= 	alu_src1_sel_in	;
            dmem_access_out    	<= 	dmem_access_in	;
            br_type_out        	<= 	br_type_in	;
            alu_res_out        	<= 	alu_res_in	;
            dmem_rd_out_out    	<= 	dmem_rd_out_in	;
            dmem_we_out        	<= 	dmem_we_in	;
            commit_out         	<= 	commit_in	;
            dmem_wdata_out     	<= 	dmem_wdata_in	;
        end
    end
end

endmodule
