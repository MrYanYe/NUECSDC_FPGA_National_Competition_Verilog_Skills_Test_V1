`timescale 1ns / 1ps

module test4(); 
	reg	 clk;		
	reg	 rst_n;
	reg	 [3:0] i_data;
	reg valid;
	wire [5:0] o_data;
	wire o_ready;
	

	initial begin
        clk=0;
		i_data  = 4'b0000;
		valid = 1'b0;
		rst_n   = 1'b1;
		#10;
		i_data  = 4'b0001;
		valid = 1'b1;
		#10;
		i_data  = 4'b0100;
		#10;
		i_data  = 4'b1000;
		valid = 1'b0;
		#10;
		i_data  = 4'b1111;
		valid = 1'b1;
		#10;
		i_data  = 4'b1001;
		#10;
		i_data  = 4'b1101;
		#10;
		i_data  = 4'b0010;
		valid = 1'b0;
		#10;
		i_data  = 4'b0011;
		valid = 1'b1;
		#10;
		i_data  = 4'b0010;
		#10;
		i_data  = 4'b1010;	
		#10
		valid=1'b0;	
	end
	
    always #5 clk=~clk;
    
	add test(
	.clk(clk),			
	.rst_n(rst_n),    
	.i_data(i_data),      
	.valid(valid),      
	.o_data(o_data),       
	.o_ready(o_ready)       
    );
endmodule
