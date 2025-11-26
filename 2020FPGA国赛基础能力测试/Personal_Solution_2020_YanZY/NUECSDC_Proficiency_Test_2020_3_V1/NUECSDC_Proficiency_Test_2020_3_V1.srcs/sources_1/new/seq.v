`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/25 16:57:29
// Design Name: 
// Module Name: seq
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


module seq( 
    input clk,  
    input i_data,//�����ź� 
    input valid,//�����ź���Ч 
    input rst_n, //ϵͳ��λ���͵�ƽ��Ч 
    output result//��Ч������� 
); 
///////////coding 

reg result_reg;
assign result = result_reg;








// The first input digit is the data in the cycle when rst_n IS TRANSITIONING to the valid state.
reg data = 0;
reg data_temp = 0;
always @(*) begin
    
    ;
    data = i_data;

end

parameter target_sequence = 6'b011_010 ;

reg K2,K1;
always @(*) begin
    ;

    result_reg = K1;
end


	 reg [3:0] state = 0;//////
     reg [3:0] next_state = 0;
     
	
    //这里定义状�?�，采用独热�?
	// parameter IDLE = 4'b1000,
	// 	  START = 4'b0100,
	// 	  STOP = 4'b0010,
	// 	  CLEAR = 4'b0001;

    parameter IDLE = 4'd0,
    s1 = 4'd1,
    s2 = 4'd2,
    s3 = 4'd3,
    s4 = 4'd4,
    s5 = 4'd5,
    s6 = 4'd6,
    
    s7 = 4'd7,
    s8 = 4'd8,
    s9 = 4'd9,
    s10 = 4'd10,
    s11 = 4'd11,
    

    s_final_semicolon = 4'd15;


    


    //这里实现时序逻辑中的状�?�转�?
    always@(negedge clk or negedge rst_n) begin
        if(!rst_n) begin
            state <= IDLE;
            // next_state <= IDLE;
        end
        // else if( valid )
        //     state <= next_state;
        else state <= next_state;
    end


    //这里实现组合逻辑中的状�?�更�?
    // always @(A) means this always block will only be triggered when signal A changes.
	// always@(posedge clk)
        reg need_to_change_in_THIS_cycle = 0;
        reg change_ena = 0 ;
    always @(posedge clk) begin
        ;
    end




    // always @( data or state ) begin
    always @( * ) begin

        // need_to_change_in_THIS_cycle <= (rst_n && clk)? 1 : 0;
        // Logical AND clk is essencial. But I don't know why.
        need_to_change_in_THIS_cycle <= (valid && (!clk) );
        change_ena = need_to_change_in_THIS_cycle;

        // change_ena = 1;

        if (change_ena) begin
            case(state)
                IDLE:
                    next_state = data ? s1 : IDLE;
                s1:
                    next_state = data ? s3 : s2;
                s2:
                    next_state = data ? s5 : IDLE;
                s3:
                    next_state = data ? s4 : s2;
                s4:
                    next_state = data ? s4 : s6;
                s5:
                    next_state = data ? s7 : s2;
                s6:
                    next_state = data ? s5 : s8;
                s7:
                    next_state = data ? s9 : s2;
                s8:
                    next_state = data ? s1 : s10;
                s9:
                    next_state = data ? s4 : s11;
                s10:
                    next_state = data ? s1 : IDLE;
                s11:
                    next_state = data ? s1 : IDLE;
                // s6:
                //     if(data == 0) next_state = s1;
                //     else next_state = sf0;



                default: next_state = IDLE;
            endcase
        end // if (change_ena)
        else
            next_state = next_state;
    end


	// 这里实现同步组合输出		
    // K2, K1 are the number on the line of Mealy Machine
    always@(negedge clk or negedge rst_n) begin
        if(!rst_n) {K2,K1} <= {1'b0,1'b0};  
        else begin
            case(state)
                // IDLE,s1,s2,s3,s4:  
                //     {K2,K1} <= {1'b0,1'b0}; 
                // sf0,sf1,sf2,sf3,sf4:
                //     {K2,K1} <= {1'b0,1'b0}; 
                // s5:
                //     {K2,K1} <= {1'b1,1'b0}; 
                // sf5:
                //     {K2,K1} <= {1'b0,1'b1}; 
                s10,s11:
                    K1 <= 1'b1;
                IDLE,s1,s2,s3,s4,s5,s6,s7,s8,s9:
                    K1 <= 1'b0;

                default:
                    // {K2,K1} <= {1'b0,1'b0}; 
                    K1 <= 1'b0;

                
            endcase
        end
    end
 
 
 
 
endmodule 

