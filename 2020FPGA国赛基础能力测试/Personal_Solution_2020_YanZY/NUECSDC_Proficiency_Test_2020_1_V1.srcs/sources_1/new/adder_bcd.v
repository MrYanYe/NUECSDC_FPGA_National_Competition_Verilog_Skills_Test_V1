`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/16 20:40:16
// Design Name: 
// Module Name: adder_bcd
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


module adder_bcd(
    input [3:0] a,//输入加数a
    input [3:0] b, //输入加数b
    input rst_n, //系统复位，低电平有效
    output [3:0] bcd1, //输入个位
    output [3:0] bcd2//输入十位
);


///////////coding

reg [3:0] bcd1_reg;
reg [3:0] bcd2_reg;

assign bcd1 = bcd1_reg;
assign bcd2 = bcd2_reg;

reg [7:0] a_plus_b_binary;
reg [4:0] a_plus_b_binary_tens_place;
reg [4:0] a_plus_b_binary_ones_place;






always @(*) begin
    if (!rst_n) begin
        bcd1_reg = 0;
        bcd2_reg = 0;
    end
    else begin
        a_plus_b_binary = a + b;                                                        
        a_plus_b_binary_tens_place = a_plus_b_binary / 10;                              
        a_plus_b_binary_ones_place = a_plus_b_binary - a_plus_b_binary_tens_place *  10;
        
        bcd1_reg = a_plus_b_binary_ones_place;
        bcd2_reg = a_plus_b_binary_tens_place;
        
    end // else
    
end







endmodule
