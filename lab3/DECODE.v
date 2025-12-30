
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/08 08:33:47
// Design Name: 
// Module Name: DECODE
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

module DECODE(
    input           [31 : 0]    inst,
    output  reg     [ 4 : 0]    alu_op,
    output  reg     [ 3 : 0]    dmem_access,
    output  reg     [31 : 0]    imm,
    output  reg     [ 4 : 0]    rf_ra0, rf_ra1, rf_wa,
    output  reg     [ 3 : 0]    br_type,
    output  reg     [ 1 : 0]    rf_wd_sel,
    output  reg     [ 0 : 0]    alu_src0_sel,   alu_src1_sel,   rf_we,	dmem_we
);
always @(*) begin
    if(inst[31:21] == 11'h0)begin
        case(inst[20:15])
            6'b100000:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b100010:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b00010; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b100100:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b00100; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b100101:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b00101; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b101001:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b01001; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b101010:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b01010; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b101011:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b01011; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b101110:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b01110; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b101111:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b01111; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            6'b110000:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = inst[14:10]; rf_we = 1; alu_op = 5'b10000; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            default:begin rf_wa = 0; rf_ra0 = 0; rf_ra1 = 0; rf_we = 0; alu_op = 0; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 0; br_type = 0; dmem_we = 0; end
        endcase
    end
    else if(inst[31:23] == 9'h0)begin
        case(inst[22:18])
            5'b10000:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b01110; alu_src0_sel = 0; alu_src1_sel = 1; imm = {27'b0,inst[14:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            5'b10001:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b01111; alu_src0_sel = 0; alu_src1_sel = 1; imm = {27'b0,inst[14:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            5'b10010:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b10000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {27'b0,inst[14:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            default:begin rf_wa = 0; rf_ra0 = 0; rf_ra1 = 0; rf_we = 0; alu_op = 0; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 0; br_type = 0; dmem_we = 0; end
        endcase
    end
    else if(inst[31:26] == 6'h0)begin
        case(inst[25:22])
            4'b1010:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            4'b1000:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b00100; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            4'b1001:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b00101; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            4'b1101:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b01001; alu_src0_sel = 0; alu_src1_sel = 1; imm =          {20'b0,inst[21:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            4'b1110:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b01010; alu_src0_sel = 0; alu_src1_sel = 1; imm =          {20'b0,inst[21:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            4'b1111:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 0; rf_we = 1; alu_op = 5'b01011; alu_src0_sel = 0; alu_src1_sel = 1; imm =          {20'b0,inst[21:10]}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            default:begin rf_wa = 0; rf_ra0 = 0; rf_ra1 = 0; rf_we = 0; alu_op = 0; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 0; br_type = 0; dmem_we = 0; end
        endcase
    end
    else if(inst[31:29] == 3'h0)begin
        case(inst[28:25])
            4'b1010:begin rf_wa = inst[4:0]; rf_ra0 = 0; rf_ra1 = 0; rf_we = 1; alu_op = 5'b10010; alu_src0_sel = 0; alu_src1_sel = 1; imm = {inst[24:5],12'b0}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            4'b1110:begin rf_wa = inst[4:0]; rf_ra0 = 0; rf_ra1 = 0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {inst[24:5],12'b0}; dmem_access = 0; rf_wd_sel = 2'b01; br_type = 0; dmem_we = 0; end
            default:begin rf_wa = 0; rf_ra0 = 0; rf_ra1 = 0; rf_we = 0; alu_op = 0; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 0; br_type = 0; dmem_we = 0; end
        endcase
    end
    else if(inst[31:26] == 6'b001010)begin
        case(inst[25:22])
            4'b0010:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 	  0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 4'b0001; rf_wd_sel = 2'b10; br_type = 0; dmem_we = 0; end
            4'b0001:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 	  0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 4'b0010; rf_wd_sel = 2'b10; br_type = 0; dmem_we = 0; end
            4'b0000:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 	  0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 4'b0011; rf_wd_sel = 2'b10; br_type = 0; dmem_we = 0; end
            4'b1001:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 	  0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 4'b0100; rf_wd_sel = 2'b10; br_type = 0; dmem_we = 0; end
            4'b1000:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 	  0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 4'b0101; rf_wd_sel = 2'b10; br_type = 0; dmem_we = 0; end
            4'b0110:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 4'b0110; rf_wd_sel = 2'b10; br_type = 0; dmem_we = 1; end
            4'b0101:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 4'b0111; rf_wd_sel = 2'b10; br_type = 0; dmem_we = 1; end
            4'b0100:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{20{inst[21]}},inst[21:10]}; dmem_access = 4'b1000; rf_wd_sel = 2'b10; br_type = 0; dmem_we = 1; end
            default:begin rf_wa = 0; rf_ra0 = 0; rf_ra1 = 0; rf_we = 0; alu_op = 0; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 0; br_type = 0; dmem_we = 0; end
        endcase
    end
    else if(inst[31:30] == 2'b01)begin
        case(inst[29:26])
            4'b0011:begin rf_wa = inst[4:0]; rf_ra0 = inst[9:5]; rf_ra1 = 	  0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 0; alu_src1_sel = 1; imm = {{14{inst[25]}},inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b00; br_type = 4'b0011; dmem_we = 0; end
            4'b0100:begin rf_wa =         0; rf_ra0 =         0; rf_ra1 = 	  0; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {{4{inst[9]}},inst[9:0],inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b11; br_type = 4'b0100; dmem_we = 0; end
            4'b0101:begin rf_wa =      5'b1; rf_ra0 =         0; rf_ra1 = 	  0; rf_we = 1; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {{4{inst[9]}},inst[9:0],inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b00; br_type = 4'b0101; dmem_we = 0; end
            4'b0110:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {{14{inst[25]}},inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b11; br_type = 4'b0110; dmem_we = 0; end
            4'b0111:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {{14{inst[25]}},inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b11; br_type = 4'b0111; dmem_we = 0; end
            4'b1000:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {{14{inst[25]}},inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b11; br_type = 4'b1000; dmem_we = 0; end
            4'b1001:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {{14{inst[25]}},inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b11; br_type = 4'b1001; dmem_we = 0; end
            4'b1010:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {{14{inst[25]}},inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b11; br_type = 4'b1010; dmem_we = 0; end
            4'b1011:begin rf_wa = 	  0; rf_ra0 = inst[9:5]; rf_ra1 = inst[4:0]; rf_we = 0; alu_op = 5'b00000; alu_src0_sel = 1; alu_src1_sel = 1; imm = {{14{inst[25]}},inst[25:10],2'b0}; dmem_access = 0; rf_wd_sel = 2'b11; br_type = 4'b1011; dmem_we = 0; end
            default:begin rf_wa = 0; rf_ra0 = 0; rf_ra1 = 0; rf_we = 0; alu_op = 0; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 0; br_type = 0; dmem_we = 0; end
        endcase
    end
    else begin
        rf_wa = 0; rf_ra0 = 0; rf_ra1 = 0; rf_we = 0; alu_op = 0; alu_src0_sel = 0; alu_src1_sel = 0; imm = 0; dmem_access = 0; rf_wd_sel = 0; br_type = 0;
    end
end

endmodule
