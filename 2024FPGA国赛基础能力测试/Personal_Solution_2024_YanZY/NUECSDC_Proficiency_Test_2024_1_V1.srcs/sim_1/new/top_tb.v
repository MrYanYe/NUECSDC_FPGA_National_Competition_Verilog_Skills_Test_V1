`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/17 23:54:09
// Design Name: 
// Module Name: top_tb
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


module top_tb();

reg          i_clk = 0;
reg          i_rst = 1;
reg          i_ena = 1;
wire         o_pm;
wire [7 : 0] o_hh;
wire [7 : 0] o_mm;
wire [7 : 0] o_ss;

top test(
    .i_clk (i_clk),
    .i_rst (i_rst),
    .i_ena (i_ena),
    .o_pm  (o_pm ),
    .o_hh  (o_hh ),
    .o_mm  (o_mm ),
    .o_ss  (o_ss )
);

always #1 i_clk = ~i_clk;

initial begin
    #3 i_rst <= 0;
    #7 i_rst <= 1;
#3 i_rst <= 0;
#1000000;
$stop;
end

endmodule
