module top_key_seg (
    input   clk,
    input   rst_n,
    input   [3:0]   key,

    output  [5:0]   seg_sel,
    output  [7:0]   seg_led
);
    
wire                en ;
wire        [23:0]  num;
parameter           MMAX = 22'd2500_000;

key_seg #(.MAX_NUM(MMAX))u_key_seg(
    .clk            (clk),
    .rst_n          (rst_n),
    .key            (key),

    .num            (num),
    .en             (en),
);

seg_led u_seg_led(
    .clk            (clk),
    .rst_n          (rst_n),
    .en             (en),
    .num            (num),

    .seg_sel        (seg_sel),
    .seg_led        (seg_led) 
);

endmodule