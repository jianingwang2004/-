`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/27 18:12:12
// Design Name: 
// Module Name: ALU_tb
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


module TOP (
    input                   [ 0 : 0]            clk,
    input                   [ 0 : 0]            rst,

    input                   [ 0 : 0]            enable,
    input                   [ 4 : 0]            in,
    input                   [ 1 : 0]            ctrl,

    output                  [ 3 : 0]            seg_data,
    output                  [ 2 : 0]            seg_an
);

reg op_en,src0_en,src1_en,res_en;
wire [31:0] alu_res;
wire [31:0] outputdata;
wire [31:0] alu_src0;
wire [31:0] alu_src1;
wire [31:0] alu_op;

always @(posedge clk)begin
    if(rst) begin
        op_en <= 1'b0;
        src0_en <= 1'b0;
        src1_en <= 1'b0;
        res_en <= 1'b0;
    end
    else begin
            case(ctrl)
                2'b00:  begin
                    if(enable) begin
                            op_en <= 1'b1;
                            src0_en <= 1'b0;
                            src1_en <= 1'b0;
                            res_en <= 1'b0;
                    end 
                    else begin
                            op_en <= 1'b0;
                            src0_en <= 1'b0;
                            src1_en <= 1'b0;
                            res_en <= 1'b0;
                    end
                end
                2'b01:  begin
                    if(enable) begin
                            op_en <= 1'b0;
                            src0_en <= 1'b1;
                            src1_en <= 1'b0;
                            res_en <= 1'b0;
                    end 
                    else begin
                            op_en <= 1'b0;
                            src0_en <= 1'b0;
                            src1_en <= 1'b0;
                            res_en <= 1'b0;
                    end
                end
                2'b10:  begin
                    if(enable) begin
                            op_en <= 1'b0;
                            src0_en <= 1'b0;
                            src1_en <= 1'b1;
                            res_en <= 1'b0;
                    end 
                    else begin
                            op_en <= 1'b0;
                            src0_en <= 1'b0;
                            src1_en <= 1'b0;
                            res_en <= 1'b0;
                    end
                end
                2'b11:  begin
                    if(enable) begin
                            op_en <= 1'b0;
                            src0_en <= 1'b0;
                            src1_en <= 1'b0;
                            res_en <= 1'b1;
                    end 
                    else begin
                            op_en <= 1'b0;
                            src0_en <= 1'b0;
                            src1_en <= 1'b0;
                            res_en <= 1'b0;
                    end
                end
            endcase
    end
end

regfile reg0(
    .clk(clk),
    .rst(rst),
    .rf_we(src0_en),
    .rf_wd({27'd0,in}),
    .rf_rd(alu_src0)
);

regfile reg1(
    .clk(clk),
    .rst(rst),
    .rf_we(src1_en),
    .rf_wd({27'd0,in}),
    .rf_rd(alu_src1)
);

regfile reg2(
    .clk(clk),
    .rst(rst),
    .rf_we(op_en),
    .rf_wd({27'd0,in}),
    .rf_rd(alu_op)
);

ALU alu(
    .alu_src0(alu_src0), 
    .alu_src1(alu_src1),
    .alu_op(alu_op[4:0]),
    .alu_res(alu_res)
);

regfile reg3(
    .clk(clk),
    .rst(rst),
    .rf_we(res_en),
    .rf_wd(alu_res),
    .rf_rd(outputdata)
);

Segment segment(
    .clk(clk),
    .rst(rst),
    .output_data(outputdata),
    .seg_data(seg_data),
    .seg_an(seg_an)
);

endmodule