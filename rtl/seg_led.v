module seg_led (
    input             clk,
    input             rst_n,
    input             en,
    input      [23:0] num,

    output reg [5:0]  seg_sel,
    output reg [7:0]  seg_led  
);

reg            [2:0]  sel_cnt;
reg                   flag;
reg            [11:0] cnt; 
reg            [3:0]  date;      

always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        flag <= 1'd0;
        cnt <= 12'd50_000;
    end
    else if(cnt > 12'd0) begin
        cnt <= cnt - 1'd1;
        flag <= 1'd0;
    end
    else if (cnt == 12'd0) begin
        cnt <= 12'd50_000;
        flag <= 1'd1;
    end 
end

always @(posedge clk, negedge rst_n) begin
    if (!rst_n) begin
        sel_cnt <= 3'd0;
    end
    else if(flag == 1'd1 && sel_cnt >= 3'd6)
        sel_cnt <= 3'd1;
    else if(flag == 1'd1 && sel_cnt < 3'd6)
        sel_cnt <= sel_cnt + 1'd1;
end

always @(posedge clk, negedge rst_n) begin
    if(!rst_n ) 
        seg_sel <= 6'b111_111;
    else if(en) begin
        case (sel_cnt)
            3'd0: begin 
                seg_sel <=6'b111_111;
            end
            3'd1: begin 
                seg_sel <=6'b111_110;
                date <= num[3:0];
            end
            3'd2: begin 
                seg_sel <=6'b111_101;
                date <= num[7:4];
            end
            3'd3: begin 
                seg_sel <=6'b111_011;
                date <= num[11:8];
            end
            3'd4: begin 
                seg_sel <=6'b110_111;
                date <= num[15:12];
            end
            3'd5: begin 
                seg_sel <=6'b101_111;
                date <= num[19:16];
            end
            3'd6: begin 
                seg_sel <=6'b011_111;
                date <= num[23:20];
            end
            default: seg_sel <= 6'b111_111;
        endcase
    end
end

always @(posedge clk, negedge rst_n) begin
    if(!rst_n)
        seg_led <= 8'hc0;
    else begin
        case (date)
            4'd0 : seg_led <= 8'b11000000; //��ʾ���� 0
            4'd1 : seg_led <= 8'b11111001; //��ʾ���� 1
            4'd2 : seg_led <= 8'b10100100; //��ʾ���� 2
            4'd3 : seg_led <= 8'b10110000; //��ʾ���� 3
            4'd4 : seg_led <= 8'b10011001; //��ʾ���� 4
            4'd5 : seg_led <= 8'b10010010; //��ʾ���� 5
            4'd6 : seg_led <= 8'b10000010; //��ʾ���� 6
            4'd7 : seg_led <= 8'b11111000; //��ʾ���� 7
            4'd8 : seg_led <= 8'b10000000; //��ʾ���� 8
            4'd9 : seg_led <= 8'b10010000; //��ʾ���� 9
            4'd10: seg_led <= 8'b11111111;           //����ʾ�κ��ַ�
            default: 
                   seg_led <= 8'b11000000;
        endcase
    end
end

endmodule