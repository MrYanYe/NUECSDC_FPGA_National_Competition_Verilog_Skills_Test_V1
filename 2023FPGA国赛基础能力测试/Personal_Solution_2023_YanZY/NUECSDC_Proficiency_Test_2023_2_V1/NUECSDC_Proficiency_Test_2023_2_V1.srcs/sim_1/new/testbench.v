`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/20 16:28:42
// Design Name: 
// Module Name: testbench
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


module testbench(); 
    reg clk, rst_n, D_in; 
wire match, not_match; 
reg [23:0] data; 
    initial begin 
        clk=0; 
        rst_n=0; 
        D_in=0; 
        data=24'b011100_011010_011110_011101; 
        #5;
//        #20; 
        rst_n=1; 
    end 
always #10 clk<=~clk; 
always@(posedge clk)begin 
    D_in <= data[23]; 
    data <= {data[22:0],data[23]}; 
end 
    sequence_detect test( 
        .clk(clk), 
        .rst_n(rst_n), 
        .data1(D_in), 
        .match(match), 
        .not_match(not_match) 
    ); 
endmodule 
