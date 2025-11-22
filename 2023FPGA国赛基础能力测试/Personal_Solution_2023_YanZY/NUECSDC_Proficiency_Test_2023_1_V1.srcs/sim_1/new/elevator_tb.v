`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/19 22:15:05
// Design Name: 
// Module Name: elevator_tb
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


module elevator_tb( 
); 
reg clk, rst_n, key; 
reg [7:0]H; 
reg [3:0]num; 
reg [9:0]weight; 
wire [7:0]N; 
wire alert; 
elevator test( 
.clk(clk), .rst_n(rst_n), 
.key(key), .H(H), .num(num), .weight(weight), 
.N(N), 
.alert(alert) 
); 
initial begin 
clk = 0; 
rst_n = 0; 
#15 
rst_n = 1; 
forever  
#5 clk = ~clk; 
end 
initial begin 
key = 0; 
H = 0; 
num = 0; 
weight = 0; 
#20 
H = 30; 
num = 1; 
weight = 50; 
#400 
H = 8; 
#10 
key = 1; 
@ (negedge clk) ;key = 0; 
#300 
H = 12; 
num = 14; 
#20 
num = 10; 
weight = 1001; 
#50 
weight = 900; 
end 
endmodule
