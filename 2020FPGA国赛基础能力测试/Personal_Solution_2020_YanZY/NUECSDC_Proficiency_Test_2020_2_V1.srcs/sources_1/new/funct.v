`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/16 23:11:33
// Design Name: 
// Module Name: funct
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


module funct ( 
    input clk, 
    input [2:0] n,//�ײ� n 
    input rst_n, //ϵͳ��λ���͵�ƽ��Ч 
    output [15:0] result//�ײ��� 
); 

reg [15:0]  result_reg = 1;
assign result = result_reg;

/* test
reg [7:0] count = 0;
always @(posedge clk or negedge rst_n) begin
    count = count + 1;
    result_reg = 3;
    if (count > 5 ) begin
        result_reg = 6;
    end
    if (count > 15) begin
        result_reg = 7;
    end
    if (count > 20) begin
        result_reg = 5;
    end

*/

reg [2:0] current_n = 0;
reg [2:0] n_that_needs_to_be_calculated;
reg [2:0] order_factorial = 1;
reg [15:0] acc = 1;

reg [2:0] i,j;

reg n_changed_flag = 0;
reg calculation_completed = 1;
reg start_calculating = 0;


always @(posedge clk or negedge rst_n) begin
    
    if(!rst_n) begin
        current_n = n;
        n_that_needs_to_be_calculated = 1;
        order_factorial = 1;
        
        n_changed_flag = 1;
        calculation_completed = 1;
        acc = 1;
        
    end // rst_n
    
    else begin
        
        if ( n != current_n ) begin
            n_changed_flag = 1;
            current_n = n;
            
        end
        
        else begin

        if ( n_changed_flag && calculation_completed )
        begin

            start_calculating = 1;
            n_changed_flag = 0;

                        n_that_needs_to_be_calculated = n;

            order_factorial = n_that_needs_to_be_calculated;


        end

        if ( start_calculating )
        begin

            calculation_completed = 0;




            if ( order_factorial > 1 )
            begin
                // 如果n=0,不会进到这个for循环
                acc = acc * order_factorial;
                order_factorial = order_factorial - 1;

            end

            else
            begin

                if ( order_factorial == 0 )

                    acc = 1;


                result_reg = acc;
                start_calculating = 0;
                calculation_completed = 1;

                acc = 1;
                n_that_needs_to_be_calculated = 1;

            end



        end
        

        end // else n != current_n

        
        // if ( calculation_completed && n_changed_flag ) 
        //     begin
            
        //     calculation_completed = 0;
        //     n_changed_flag = 0;

        //     n_that_needs_to_be_calculated = n;
        //     acc = 1;
            
            
        //      order_factorial = n_that_needs_to_be_calculated; 
        //      if (calculation_completed == 0)
        //      begin
        //         acc = acc * order_factorial;
        //         order_factorial = order_factorial - 1 ;

        //         if ( order_factorial == 1)
        //             begin
        //                             // Calclation completed
        //             result_reg = acc;
        //             calculation_completed = 1;
                    
        //             acc = 1;


        //             end

        //      end



            
                
            


        //     end

        // if ( order_factorial == 1 )
        // begin



        // end

            
            
        
        
    
    
    
    end // top else
    
    
    
end // always










///////////coding 
endmodule 
