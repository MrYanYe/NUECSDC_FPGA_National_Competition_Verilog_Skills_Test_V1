`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 23:30:44
// Design Name: 
// Module Name: digital_clock_tb
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


module digital_clock_tb(

    );

	reg clk;
	reg rst_n;
	reg en;
	wire [7:0] hour;
	wire [7:0] min;
	wire [7:0] sec;
	wire tweet;


	initial begin
		clk = 0;
		forever begin
			#5 clk = ~clk;
		end
	end

	initial begin
		rst_n = 0;
		en = 0;
		# 50
		@(negedge clk) 
		rst_n = 1;
		@(negedge clk) 
		en = 1;

		// #10000000 $finish;


	end












	digital_clock inst_digital_clock(
		.clk(clk),
		.rst_n(rst_n),
		.en(en),
		.hour(hour),
		.min(min),
		.sec(sec),
		.tweet(tweet)
		);


endmodule
