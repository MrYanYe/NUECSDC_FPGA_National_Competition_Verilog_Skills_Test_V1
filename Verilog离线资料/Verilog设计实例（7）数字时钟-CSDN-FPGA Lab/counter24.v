//8421BCD码计数器，模24
module counter24(clk, rst_n, en, dout);
 
input clk, rst_n, en;
output[7:0] dout;
reg[7:0] dout;
 
always@(posedge clk or negedge rst_n)          //异步复位
begin
	if(!rst_n)       //复位信号有效时，输出清零
		dout <= 8'b00000000;
	else if(en == 1'b0)   //计数使能无效时，输出不变
		dout <= dout;
	else if( (dout[7:4] == 4'b0010)&&(dout[3:0] == 4'b0011) )  //计数达到23时，输出清零
		dout <= 8'b00000000;
	else if(dout[3:0] == 4'b1001)       //低位达到9时，低位清零，高位加1
	begin
		dout[3:0] <= 4'b0000;
		dout[7:4] <= dout[7:4] + 1'b1;
	end
	else                     //上述情况都没有发生，则高位不变，低位加1
	begin
		dout[7:4] <= dout[7:4];
		dout[3:0] <= dout[3:0] + 1'b1;
	end
end
endmodule