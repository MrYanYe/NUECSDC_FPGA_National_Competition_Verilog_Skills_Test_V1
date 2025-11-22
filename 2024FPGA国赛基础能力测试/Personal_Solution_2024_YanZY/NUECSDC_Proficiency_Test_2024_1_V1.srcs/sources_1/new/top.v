`timescale 1ns / 1ps


//module top(
//    input          i_clk,
//    input          i_rst,
//    input          i_ena,
//    output         o_pm,
//    output [7 : 0] o_hh,
//    output [7 : 0] o_mm,
//    output [7 : 0] o_ss
//);
//endmodule



module top(
//	input clk,
//    input rst_n,
//    input en,

//    output  [5:0] an,   //片�??
//    output  [7:0] sseg,  //段�??
//    output tweet //整点报时

    input          i_clk,
    input          i_rst,
    input          i_ena,
    output         o_pm,
    output [7 : 0] o_hh,
    output [7 : 0] o_mm,
    output [7 : 0] o_ss



    );
	   

    wire [7:0] hour;
	wire [7:0] min;
	wire [7:0] sec;


	digital_clock inst_digital_clock(
		.clk(i_clk),
		.rst_n(!i_rst),
		.en(i_ena),
		.hour(o_hh),
		.min(o_mm),
		.sec(o_ss),
		.o_pm(o_pm)
		);













endmodule
