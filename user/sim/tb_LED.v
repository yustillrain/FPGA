`timescale 1ns/1ns
module tb_LED();

reg clk;
reg rst_n;
wire [2:0] led;

LED u_LED(
    .clk(clk),
    .rst_n(rst_n),
    .led(led)
);

initial begin
    rst_n = 0;
    #20
    rst_n = 1;

end

initial begin
    clk = 0;
    forever #10 clk = ~clk; // 50MHz
end

initial begin
    $dumpfile("tb_LED.vcd");
    $dumpvars(0, tb_LED);
    #5000_000_000
    $finish;
end

endmodule