`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/28 18:21:45
// Design Name: 
// Module Name: tb_traffic
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


 `timescale 1ns/1ns
 module tb_traffic();
 reg clk = 0;
 reg rst_n = 0;
 reg ped_btn = 0;
 wire [1:0] main_light;
 wire [1:0] ped_light;
 traffic_button_ctrl u_dut(
 .clk(clk), .rst_n(rst_n),
 .ped_btn(ped_btn),
 .main_light(main_light), .ped_light(ped_light)
 );
 always #5 clk = ~clk;
 initial begin
 rst_n = 0; #10 rst_n = 1;
 #340;
 ped_btn = 1;//行人红灯按下
#10;
 ped_btn = 0;
 #270
 ped_btn = 1;//行人绿灯按下
#10;
 ped_btn = 0;
 #150
 ped_btn = 1;//行人红灯按下
#10;
 ped_btn = 0;
 #150;
 ped_btn = 1;//行人连续按下
#10;
 ped_btn = 0;
 #50;
 $stop;
 end
 endmodule
