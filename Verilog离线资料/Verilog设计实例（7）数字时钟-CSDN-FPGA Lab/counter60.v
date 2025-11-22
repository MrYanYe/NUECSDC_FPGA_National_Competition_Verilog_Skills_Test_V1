//模60计数器的Verilog HDL设计
module counter60(clk, rst_n, en, dout, co);
 
input clk, rst_n, en;
output[7:0] dout;
output co;
wire co10_1, co10, co6;
wire[3:0] dout10, dout6;
 
counter10 inst_counter10(.clk(clk), .rst_n(rst_n), .en(en), .dout(dout10), .co(co10_1)); //模10计数器的进位为co10_1
and u3(co10,en,co10_1); //co10_1与en的与为co10
counter6 inst_counter6(.clk(clk), .rst_n(rst_n), .en(co10), .dout(dout6), .co(co6)); //co10_1与en的与为co10,作为模6计数器的使能信号
and u4(co, co10, co6); //模6计数器的进位和模6的使能信号co10的与作为模60计数器的进位
 
assign dout = {dout6,dout10}; //模60计数器的输出，高位为模6计数器的输出，低位为模10计数器的输出，读法是8421BCD码读法
 
endmodule
 

 

 
 