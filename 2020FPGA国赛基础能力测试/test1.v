`timescale 1ns / 1ps

module test1();
    reg [3:0] a;
    reg [3:0] b;
    reg rst_n;
    wire [3:0] bcd1;
    wire [3:0] bcd2;
    
    initial begin
        rst_n=1;
        a=4'b1011;
        b=4'b1001;
        #20
        a=4'b1111;
        b=4'b1111;
        rst_n=0;
        #10
        rst_n=1;
        #20
        a=4'b1000;
        b=4'b1001;
    end

    adder_bcd test(
        .a(a),
        .b(b),
        .rst_n(rst_n),
        .bcd1(bcd1),
        .bcd2(bcd2)
    );
endmodule
