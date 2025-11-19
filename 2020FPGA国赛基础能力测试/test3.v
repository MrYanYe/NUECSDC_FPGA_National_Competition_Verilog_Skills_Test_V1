`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/01 19:45:29
// Design Name: 
// Module Name: seq_tb
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


module test3();

    reg clk;
    reg i_data;
    reg valid;
    reg rst_n;
    wire result;
    
    
    
        initial begin
        clk=0;
        rst_n=1;
        i_data=0;
        valid=1;
        #10
        rst_n=0;
        #10
        rst_n=1;
        i_data=1;
        valid=1;
        #10
        i_data=1;
        valid=1;
        #10
        i_data=0;
        valid=1;
        #10
        i_data=1;
        valid=0;
        #10
        i_data=1;
        valid=1;
        #10
        i_data=1;
        valid=1;  
        #10
        i_data=1;
        valid=1;
        #10
        i_data=0;
        valid=1;
        #10
        i_data=0;
        valid=1;
        #10
        i_data=0;
        valid=1;  
        i_data=0;
        valid=1;
        #10
        i_data=1;
        valid=1;
        #10
        i_data=0;
        valid=1;  
    end 
    
    always #5 clk=~clk;
    


    
    seq seq(
    . clk(clk), 
    . i_data(i_data),//输入信号
    . valid(valid),//输入信号有效
    . rst_n(rst_n), //系统复位，低电平有效
    . result(result)//有效序列输出
    );
endmodule
