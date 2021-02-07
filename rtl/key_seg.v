module key_seg (
    input              clk,
    input              rst_n,
    input       [3:0]  key,

    output  reg [23:0] num,
    output  reg        en
);

reg                    flag;
parameter              MAX_NUM = 22'd2500_000;
reg             [21:0] cnt;

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        flag <= 1'd0;  
        cnt <= 22'd2500_000;
    end
    else if(cnt > 22'd0) begin
        flag <= 1'd0;
        cnt <= cnt - 22'd1;
    end
    else if(cnt == 22'd0) begin
        flag <= 1'd1;
        cnt <= 22'd2500_000;
    end
           
end

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        en <= 0;
        num <= 24'd0;
    end    
    else if(flag == 1'd1) begin
        en <= 1;
        case(key)
        4'b0111:    num[3:0] <= num[3:0] + 1'd1;
        4'b1011:    num[7:4] <= num[7:4] + 1'd1;
        4'b1101:    num[11:8] <= num[11:8] + 1'd1;
        4'b1110:    num[15:12] <= num[15:12] + 1'd1;
        endcase    
    end
   else if(num[3:0] >= 4'd10) begin
        num[3:0] <= num[3:0] - 4'd10;
        num[7:4] <= num[7:4] + 4'd1;
    end

   else if(num[7:4] >= 4'd10) begin
        num[7:4] <= num[7:4] - 4'd10;
        num[11:8] <= num[11:8] + 4'd1;
    end

    else if(num[11:8] >= 4'd10) begin
        num[11:8] <= num[11:8] - 4'd10;
        num[15:12] <= num[15:12] + 4'd1;
    end

    else if(num[15:12] >= 4'd10) begin
        num[15:12] <= num[15:12] - 4'd10;
        num[19:16] <= num[19:16] + 4'd1;
    end

    else if(num[19:16] >= 4'd10) begin
        num[19:16] <= num[19:16] - 4'd10;
        num[23:20] <= num[23:20] + 4'd1;
    end

    else if(num[23:20] >= 4'd10) 
        num[23:20] <= num[23:20] - 4'd10;

end
    

endmodule