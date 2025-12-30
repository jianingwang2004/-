module cache #(
    parameter INDEX_WIDTH       = 3,
    parameter LINE_OFFSET_WIDTH = 2,
    parameter SPACE_OFFSET      = 2,
    parameter WAY_NUM           = 2
)(
    input                         clk,    
    input                         rstn,

    input            [ 31 : 0]    addr,
    input                         r_req,
    input                         w_req,
    input            [ 31 : 0]    w_data,
    output           [ 31 : 0]    r_data,
    output    reg                 miss,

    output    reg                 mem_r,
    output    reg                 mem_w,
    output    reg    [ 31 : 0]    mem_addr,
    output    reg    [127 : 0]    mem_w_data,
    input            [127 : 0]    mem_r_data,
    input                         mem_ready
);

    localparam
        LINE_WIDTH = 32 << LINE_OFFSET_WIDTH,
        TAG_WIDTH = 32 - INDEX_WIDTH - LINE_OFFSET_WIDTH - SPACE_OFFSET,
        SET_NUM   = 1 << INDEX_WIDTH;
    
    reg    [          31 : 0]    addr_buf;
    reg    [          31 : 0]    w_data_buf;
    reg                          op_buf;
    reg    [LINE_WIDTH-1 : 0]    ret_buf;

    wire    [      INDEX_WIDTH-1 : 0]    r_index;
    wire    [      INDEX_WIDTH-1 : 0]    w_index;
    wire    [     2*LINE_WIDTH-1 : 0]    r_line;       //I DO
    wire    [       LINE_WIDTH-1 : 0]    r_line_wb;    //I DO
    wire    [       LINE_WIDTH-1 : 0]    w_line;
    wire    [       LINE_WIDTH-1 : 0]    w_line_mask;
    wire    [       LINE_WIDTH-1 : 0]    w_data_line;
    wire    [        TAG_WIDTH-1 : 0]    tag;
    wire    [      2*TAG_WIDTH-1 : 0]    r_tag;        //I DO
    wire    [LINE_OFFSET_WIDTH-1 : 0]    word_offset;
    reg     [                 31 : 0]    cache_data;
    reg     [                 31 : 0]    mem_data;
    wire    [                 31 : 0]    dirty_mem_addr;
    wire    [                  1 : 0]    valid;        //I DO
    wire    [                  1 : 0]    dirty;        //I DO
    reg                                  w_valid;
    reg                                  w_dirty;
    wire    [                  1 : 0]    hit;          //I DO

    reg                addr_buf_we;
    reg                ret_buf_we;
    reg    [ 1 : 0]    data_we;       //I DO
    reg    [ 1 : 0]    tag_we;        //I DO
    reg                data_from_mem;
    reg                refill;

//I DO
    reg    [7 : 0]    age;
    reg                tar;
    reg                tar_n;


    localparam 
        IDLE      = 3'd0,
        READ      = 3'd1,
        MISS      = 3'd2,
        WRITE     = 3'd3,
        W_DIRTY   = 3'd4;
    reg    [2 : 0]    CS;
    reg    [2 : 0]    NS;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            CS <= IDLE;
        end else begin
            CS <= NS;
        end
    end

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            addr_buf <= 0;
            ret_buf <= 0;
            w_data_buf <= 0;
            op_buf <= 0;
            refill <= 0;
            age <= 0;                 //I DO
        end 
        else begin
            if (addr_buf_we) begin
                addr_buf <= addr;
                w_data_buf <= w_data;
                op_buf <= w_req;
                tar <= tar_n;         //I DO
            end
            if (ret_buf_we) begin
                ret_buf <= mem_r_data;
            end
            if (CS == MISS && mem_ready) begin
                refill <= 1;
            end
            if (CS == IDLE) begin
                refill <= 0;
            end
        end
    end

    assign r_index = addr[INDEX_WIDTH + LINE_OFFSET_WIDTH + SPACE_OFFSET - 1 : LINE_OFFSET_WIDTH + SPACE_OFFSET];
    assign w_index = addr_buf[INDEX_WIDTH + LINE_OFFSET_WIDTH + SPACE_OFFSET - 1 : LINE_OFFSET_WIDTH + SPACE_OFFSET];
    assign tag = addr_buf[31 : INDEX_WIDTH + LINE_OFFSET_WIDTH + SPACE_OFFSET];
    assign word_offset = addr_buf[LINE_OFFSET_WIDTH + SPACE_OFFSET - 1 : SPACE_OFFSET];

    assign dirty_mem_addr = (tar == 4'd0) ? {r_tag[    TAG_WIDTH - 1 :         0], w_index} << (LINE_OFFSET_WIDTH + SPACE_OFFSET) : 
                            (tar == 4'd1) ? {r_tag[2 * TAG_WIDTH - 1 : TAG_WIDTH], w_index} << (LINE_OFFSET_WIDTH + SPACE_OFFSET) :
                                        { {(TAG_WIDTH){1'b0}} , w_index} << (LINE_OFFSET_WIDTH + SPACE_OFFSET);//I DO


    bram #(
        .ADDR_WIDTH(INDEX_WIDTH),
        .DATA_WIDTH(TAG_WIDTH + 2)
    ) tag_bram0(
        .clk(clk),
        .raddr(r_index),
        .waddr(w_index),
        .din({w_valid, w_dirty, tag}),
        .we(tag_we[0]),                                         //I DO
        .dout({valid[0], dirty[0], r_tag[TAG_WIDTH - 1 : 0]})     //I DO
    );
    bram #(
        .ADDR_WIDTH(INDEX_WIDTH),
        .DATA_WIDTH(TAG_WIDTH + 2)
    ) tag_bram1(
        .clk(clk),
        .raddr(r_index),
        .waddr(w_index),
        .din({w_valid, w_dirty, tag}),
        .we(tag_we[1]),                                          //I DO
        .dout({valid[1], dirty[1], r_tag[2 * TAG_WIDTH - 1 : TAG_WIDTH]})//I DO
    );

    bram #(
        .ADDR_WIDTH(INDEX_WIDTH),
        .DATA_WIDTH(LINE_WIDTH)
    ) data_bram0(
        .clk(clk),
        .raddr(r_index),
        .waddr(w_index),
        .din(w_line),
        .we(data_we[0]),                                //I DO
        .dout(r_line[LINE_WIDTH - 1 : 0])               //I DO
    );
    bram #(
        .ADDR_WIDTH(INDEX_WIDTH),
        .DATA_WIDTH(LINE_WIDTH)
    ) data_bram1(
        .clk(clk),
        .raddr(r_index),
        .waddr(w_index),
        .din(w_line),
        .we(data_we[1]),                                //I DO
        .dout(r_line[2 * LINE_WIDTH - 1 : LINE_WIDTH])    //I DO
    );


    assign hit[0] = valid[0] && r_tag[    TAG_WIDTH - 1 :         0] == tag;//I DO
    assign hit[1] = valid[1] && r_tag[2 * TAG_WIDTH - 1 : TAG_WIDTH] == tag;//I DO

    assign r_line_wb =   hit[0] ? r_line[LINE_WIDTH - 1 : 0] :
                        hit[1] ? r_line[2 * LINE_WIDTH - 1 : LINE_WIDTH] : {(LINE_WIDTH){1'b0}};//I DO
    
    always @(posedge clk) begin
        age[r_index] <= $random%2;
    end
    
    always @(posedge clk) begin
        if (tar == 0) age[r_index] <= 0;
        else if (tar == 1) age[r_index] <= 1;
    end// I DO
    
    reg [31:0] dirty_mem_addr_buf;
    reg [127:0] dirty_mem_data_buf;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            dirty_mem_addr_buf <= 0;
            dirty_mem_data_buf <= 0;
        end 
        else begin
            if (CS == READ || CS == WRITE) begin
                dirty_mem_addr_buf <= dirty_mem_addr;
                dirty_mem_data_buf <= (tar == 4'd0) ? r_line[LINE_WIDTH - 1 : 0] : 
                                      (tar == 4'd1) ? r_line[2 * LINE_WIDTH - 1 : LINE_WIDTH] : {(LINE_WIDTH){1'b0}};
            end//I DO
        end
    end
    
    assign w_line_mask = 32'hFFFFFFFF << (word_offset*32);
    assign w_data_line = w_data_buf << (word_offset*32);
    assign w_line = (CS == IDLE && op_buf) ? ret_buf & ~w_line_mask | w_data_line :
                    (CS == IDLE) ? ret_buf :
                    r_line_wb & ~w_line_mask | w_data_line;

    always @(*) begin
        case (word_offset)
            0: begin
                cache_data = r_line_wb[31:0];//I DO
                mem_data = ret_buf[31:0];
            end
            1: begin
                cache_data = r_line_wb[63:32];// I DO
                mem_data = ret_buf[63:32];
            end
            2: begin
                cache_data = r_line_wb[95:64];// I DO
                mem_data = ret_buf[95:64];
            end
            3: begin
                cache_data = r_line_wb[127:96];// I DO
                mem_data = ret_buf[127:96];
            end
            default: begin
                cache_data = 0;
                mem_data = 0;
            end
        endcase
    end

    assign r_data = data_from_mem ? mem_data : hit ? cache_data : 0;

    always @(*) begin
        case(CS)
            IDLE: begin
                if (r_req) begin
                    NS = READ;
                end else if (w_req) begin
                    NS = WRITE;
                end else begin
                    NS = IDLE;
                end
            end
            READ: begin
                if (miss && !dirty[tar]) begin//I DO
                    NS = MISS;
                end else if (miss && dirty[tar]) begin //I DO
                    NS = W_DIRTY;
                end else if (r_req) begin
                    NS = READ;
                end else if (w_req) begin
                    NS = WRITE;
                end else begin
                    NS = IDLE;
                end
            end
            MISS: begin
                if (mem_ready) begin
                    NS = IDLE;
                end else begin
                    NS = MISS;
                end
            end
            WRITE: begin
                if (miss && !dirty[tar]) begin //I DO
                    NS = MISS;
                end else if (miss && dirty[tar]) begin //I DO
                    NS = W_DIRTY;
                end else if (r_req) begin
                    NS = READ;
                end else if (w_req) begin
                    NS = WRITE;
                end else begin
                    NS = IDLE;
                end
            end
            W_DIRTY: begin
                if (mem_ready) begin
                    NS = MISS;
                end else begin
                    NS = W_DIRTY;
                end
            end
            default: begin
                NS = IDLE;
            end
        endcase
    end

    always @(*) begin
        addr_buf_we   = 1'b0;
        ret_buf_we    = 1'b0;
        data_we       = 2'b0;
        tag_we        = 2'b0;
        w_valid       = 1'b0;
        w_dirty       = 1'b0;
        data_from_mem = 1'b0;
        miss          = 1'b0;
        mem_r         = 1'b0;
        mem_w         = 1'b0;
        mem_addr      = 32'b0;
        mem_w_data    = 0;
        case(CS)
            IDLE: begin
                addr_buf_we = 1'b1;
                miss = 1'b0;
                ret_buf_we = 1'b0;
                if(refill) begin
                    data_from_mem = 1'b1;
                    w_valid = 1'b1;
                    w_dirty = 1'b0;
                    data_we = 1 << tar;//I DO
                    tag_we = 1 << tar; //I DO
                    if (op_buf) begin
                        w_dirty = 1'b1;
                    end 
                end
            end
            READ: begin
                data_from_mem = 1'b0;
                if (hit != 2'b0) begin
                    miss = 1'b0;
                    addr_buf_we = 1'b1;
                end else begin
                    miss = 1'b1;
                    addr_buf_we = 1'b0; 
                    if(dirty[tar])begin //I DO
                        mem_w = 1'b1;
                        mem_addr = dirty_mem_addr;
                        mem_w_data = r_line[tar * LINE_WIDTH +: LINE_WIDTH]; // I DO
                    end
                end
            end
            MISS: begin
                miss = 1'b1;
                mem_r = 1'b1;
                mem_addr = addr_buf;
                if (mem_ready) begin
                    mem_r = 1'b0;
                    ret_buf_we = 1'b1;
                end 
            end
            WRITE: begin
                data_from_mem = 1'b0;
                if (hit!=2'b0) begin
                    miss = 1'b0;
                    addr_buf_we = 1'b1;
                    w_valid = 1'b1;
                    w_dirty = 1'b1;
                    if(hit[0]) begin  // I DO
                        data_we = 2'h1;
                        tag_we = 2'h1;
                    end
                    else begin       // I DO
                        data_we = 2'h2;
                        tag_we = 2'h2;
                    end   
                end else begin
                    miss = 1'b1;
                    addr_buf_we = 1'b0; 
                    if(dirty[tar])begin  //I DO
                        mem_w = 1'b1;
                        mem_addr = dirty_mem_addr;
                        mem_w_data = r_line[tar * LINE_WIDTH +: LINE_WIDTH]; // I DO
                    end
                end
            end
            W_DIRTY: begin
                miss = 1'b1;
                mem_w = 1'b1;
                mem_addr = dirty_mem_addr_buf;
                mem_w_data = dirty_mem_data_buf;
                if (mem_ready) begin
                    mem_w = 1'b0;
                end
            end
            default:;
        endcase
    end
    
always @(posedge clk) begin // I DO
    if(age[r_index]) tar_n <= 0;
    else tar_n <= 1;
end

endmodule