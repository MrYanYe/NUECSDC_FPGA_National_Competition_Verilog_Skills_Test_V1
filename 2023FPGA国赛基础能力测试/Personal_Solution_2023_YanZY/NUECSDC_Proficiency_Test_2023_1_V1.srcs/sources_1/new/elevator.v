`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/19 22:14:53
// Design Name: 
// Module Name: elevator
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


module elevator#(parameter floor = 40)( 
    input clk, rst_n, 
    input key, [7:0]H,[3:0]num, [9:0]weight, 
    output reg [7:0]N, 
    output alert 
); 

reg alert_reg = 0;
assign alert = alert_reg;

reg [7:0] target_floor = 0;





always @(posedge clk)
begin
    
    // Ensure the target floor
    if ( H >= 1 && H <= floor )
    begin
        if ( H >=2 && H <=9 )
        begin
            ;
            if ( key == 1  )
                target_floor = H;
        end
        else
        begin
            // Normal floors
            target_floor = H;
        end

    end

end // Ensure the target floor





//     reg need_to_move_in_THIS_clk_period = 0;
//     reg move_ena ;
//     always @( posedge clk or negedge rst_n ) begin
//         ;
//         if (!rst_n) begin
    
//             need_to_move_in_THIS_clk_period <= 0;
// //            move_ena <= 0;
//         end
//         else begin
//             need_to_move_in_THIS_clk_period <= ( target_floor != N && ( target_floor >=1 && target_floor <= 40 ) ) ? 1:0;
//            move_ena <= need_to_move_in_THIS_clk_period;
//         end
//     end





always @(*)
begin
    ;
    // alert
    if ( num > 13 )
        alert_reg = 1;
    if ( weight > 1000 )
        alert_reg = 1;

end // Alert











    reg need_to_move_in_THIS_clk_period = 0;
    reg move_ena ;


always @( posedge clk or negedge rst_n )
begin
    ;


    if( !rst_n )
    begin
        N = 1;
        target_floor = 0;
            need_to_move_in_THIS_clk_period <= 0;
           move_ena <= 0;


    end // if( !rst_n )
    else begin







        //////////////////////////////
        need_to_move_in_THIS_clk_period <= ( target_floor != N && ( target_floor >=1 && target_floor <= 40 ) ) ? 1:0;
         move_ena = need_to_move_in_THIS_clk_period;
        // You must place the block above before the update of the corresponding variables
        // in the SAME always block.
        // Or the variables in two always blocks can not be synchronously changed in one posedgeCLK.
        //////////////////////////////




        if ( move_ena )
        begin
            ;
            if ( target_floor > N )
                N = N + 1;
            if ( target_floor < N )
                N = N - 1;

        end
    end
end









endmodule
