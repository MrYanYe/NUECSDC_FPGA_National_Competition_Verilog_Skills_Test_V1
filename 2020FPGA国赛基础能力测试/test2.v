`timescale 1ns / 1ps

module test2();
    reg clk;
    reg [2:0] n;
    reg rst_n;
    wire [15:0] result;
    
    initial begin
        clk=0;
        rst_n=1;
        n=3'b100;
        #50
        n=3'b111;
        #150
        n=3'b000;
    end 
    
    always #5 clk=~clk;
    
    funct test(
        .clk(clk),
        .n(n),
        .rst_n(rst_n),
        .result(result)
    );
endmodule
