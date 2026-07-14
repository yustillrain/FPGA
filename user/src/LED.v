module LED 
(
    input wire clk, //50MHz 20ns 1s = 50000_000(26'd) * 20ns   2s = 100000_000(27'd) * 20ns
    input wire rst_n,
    output reg [2:0] led
);

//比较结点
parameter CNT_1S = 26'd50000000; 
parameter CNT_2s = 27'd100000000; //计数器最大值
parameter CNT_3s = 28'd150000000; //计数器最大值 3s 28
//计数器
reg [27:0] cnt; //27位计数器 0-4999 9999

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        cnt <= 27'd0;
    end
    else if(cnt == CNT_3s ) begin  //最后一个上升沿,比较count = 1500 0000!!!
        cnt <= 27'd0;
    end
    else begin
        cnt <= cnt + 1'd1;
    end
end

//led灯控制
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        led <= 3'b111;
    end
    else if(cnt < CNT_1S) begin // count = 1时刻开始 count = 5000 0001时刻结束
        led <= 3'b001;
    end
    else if(cnt >= CNT_1S && cnt < CNT_2s) begin  //count = 5000 0001时刻开始 到1 0000 0001时刻结束
        led <= 3'b010;
    end
    else if(cnt >= CNT_2s && cnt < CNT_3s) begin //count = 1 0000 0001时刻开始 到1 5000 0001时刻结束
        led <= 3'b100;
    end
    else begin
        led <= 3'b111;
    end
end

endmodule