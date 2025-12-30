module Forwarding(
    input [ 0 : 0] rf_we_mem,
    input [ 0 : 0]  rf_we_wb,
    input [ 4 : 0] rf_wa_mem,
    input [ 4 : 0]  rf_wa_wb,
    input [31 : 0] rf_wd_mem,
    input [31 : 0]  rf_wd_wb,
    input [ 4 : 0] rf_ra0_ex,
    input [ 4 : 0] rf_ra1_ex,
    output reg[ 0 : 0] rf_rd0_fe,
    output reg[ 0 : 0] rf_rd1_fe,
    output reg[31 : 0] rf_rd0_fd,
    output reg[31 : 0] rf_rd1_fd
    );
always @(*) begin
    if (rf_we_mem == 1 && rf_wa_mem != 0 && rf_we_wb == 1 && rf_wa_wb != 0) begin
        if (rf_wa_mem == rf_ra0_ex && rf_wa_wb == rf_ra1_ex) begin
            rf_rd0_fe = 1;
            rf_rd1_fe = 1;
            rf_rd0_fd = rf_wd_mem;
            rf_rd1_fd = rf_wd_wb;
        end 
        else if (rf_wa_mem == rf_ra1_ex && rf_wa_wb == rf_ra0_ex) begin
            rf_rd0_fe = 1;
            rf_rd1_fe = 1;
            rf_rd0_fd = rf_wd_wb;
            rf_rd1_fd = rf_wd_mem;
        end
        else if (rf_wa_mem == rf_ra0_ex) begin
            rf_rd0_fe = 1;
            rf_rd1_fe = 0;
            rf_rd0_fd = rf_wd_mem;
            rf_rd1_fd = 0;
        end
        else if (rf_wa_mem == rf_ra1_ex) begin
            rf_rd0_fe = 0;
            rf_rd1_fe = 1;
            rf_rd0_fd = 0;
            rf_rd1_fd = rf_wd_mem;
        end
        else if (rf_wa_wb == rf_ra0_ex) begin
            rf_rd0_fe = 1;
            rf_rd1_fe = 0;
            rf_rd0_fd = rf_wd_wb;
            rf_rd1_fd = 0;
        end
        else if (rf_wa_wb == rf_ra1_ex) begin
            rf_rd0_fe = 0;
            rf_rd1_fe = 1;
            rf_rd0_fd = 0;
            rf_rd1_fd = rf_wd_wb;
        end
        else begin
            rf_rd0_fe = 0;
            rf_rd1_fe = 0;
            rf_rd0_fd = 0;
            rf_rd1_fd = 0;
        end
    end
    else if (rf_we_mem == 1 && rf_wa_mem != 0) begin
        if (rf_wa_mem == rf_ra0_ex) begin
            rf_rd0_fe = 1;
            rf_rd1_fe = 0;
            rf_rd0_fd = rf_wd_mem;
            rf_rd1_fd = 0;
        end
        else if (rf_wa_mem == rf_ra1_ex) begin
            rf_rd0_fe = 0;
            rf_rd1_fe = 1;
            rf_rd0_fd = 0;
            rf_rd1_fd = rf_wd_mem;
        end
        else begin
            rf_rd0_fe = 0;
            rf_rd1_fe = 0;
            rf_rd0_fd = 0;
            rf_rd1_fd = 0;
        end
    end
    else if (rf_we_wb == 1 && rf_wa_wb != 0) begin
        if (rf_wa_wb == rf_ra0_ex) begin
            rf_rd0_fe = 1;
            rf_rd1_fe = 0;
            rf_rd0_fd = rf_wd_wb;
            rf_rd1_fd = 0;
        end
        else if (rf_wa_wb == rf_ra1_ex) begin
            rf_rd0_fe = 0;
            rf_rd1_fe = 1;
            rf_rd0_fd = 0;
            rf_rd1_fd = rf_wd_wb;
        end
        else begin
            rf_rd0_fe = 0;
            rf_rd1_fe = 0;
            rf_rd0_fd = 0;
            rf_rd1_fd = 0;
        end
    end
    else begin
        rf_rd0_fe = 0;
        rf_rd1_fe = 0;
        rf_rd0_fd = 0;
        rf_rd1_fd = 0;
    end
end
endmodule
