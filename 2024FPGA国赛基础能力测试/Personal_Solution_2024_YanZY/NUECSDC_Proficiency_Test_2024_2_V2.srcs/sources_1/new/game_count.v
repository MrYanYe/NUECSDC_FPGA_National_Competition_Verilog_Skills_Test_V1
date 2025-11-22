`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/18 14:54:33
// Design Name: 
// Module Name: game_count
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

module game_count(
    input rst_n, 
    input clk, 
    input [9:0]money,
    input set,
    input [1:0]boost,
    output [9:0]remain,
    output yellow,
    output red
);

reg [9:0] reamin_reg = 0;
assign remain = reamin_reg;
reg yellow_reg;
assign yellow = yellow_reg;
reg red_reg;
assign red = red_reg;

parameter       IDLE        = 2'b00;
parameter       NORMAL      = 2'b01;
parameter       PLAY        = 2'b10;
parameter       TRIAL       = 2'b11;
reg [1:0] state = IDLE;

parameter       TRIAL_mode_time_limit = 4'd5 - 1 ;

reg trial_count = 1;
reg [4:0] trial_time_spent = 0;

// reg first_minute; 
// To avoid deducting money in the first clock period after 
// entering the NORMAL/PLAY mode



// reg need_to_deduct_in_THIS_cycle = 0;
// reg deduct_ena = 0;
// always @(posedge clk or negedge rst_n) begin
//     ;
//     if (!rst_n) begin
//         need_to_deduct_in_THIS_cycle = 0;
//         deduct_ena = 0;
//     end
//     else begin
//         ;
//         need_to_deduct_in_THIS_cycle = ( (state == NORMAL && reamin_reg >= 1) || (state == PLAY && reamin_reg >= 2) ) ? 1 : 0;
//         deduct_ena <= need_to_deduct_in_THIS_cycle;
//     end

// end




always @( * )
begin
            // Light Warning
        if ( state != IDLE )
        begin
            if ( reamin_reg < 10 && reamin_reg > 0  )
            begin
                yellow_reg = 1;
                red_reg = 0;
            end

            else if ( reamin_reg == 0  )
            begin
                red_reg = 1;
                yellow_reg = 0;
            end

            else
            begin
                red_reg = 0;
                yellow_reg = 0;
            end
        end
end




always @( posedge set )
begin
            // top up
        if ( set )
        begin
            reamin_reg = reamin_reg + money  ;
        end
end




// // Determine the cost per minute in different modes
// reg [3:0] cost_per_minute;
// always @(posedge clk) begin
//     // Note that you need to use sequential order here
//     ;


//         case (state)
//             IDLE:
//             begin
//                 cost_per_minute = 0;
//             end

//             NORMAL:
//             begin
//                 cost_per_minute = 1;
//             end

//             PLAY:
//             begin
//                 cost_per_minute = 2;
//             end

//             TRIAL:
//             begin
//                 cost_per_minute = 0;
//             end

//             default: 
//             begin
//                 cost_per_minute = 0;
//             end

//         endcase


// end




// // Determine the next state

// reg [1:0] next_state;
// always @(posedge clk) begin
//     // Note that you need to use sequential order here, not (*)
//     // Or the change of "state" will conflict with 
//     //      if (trial_time_spent == TRIAL_mode_time_limit)
//     //      begin
//     //          state = NORMAL;
//     ;
//     if ( boost == TRIAL ) begin
//         ;
//         if (trial_count == 0) begin
//             state = state;
//         end
//         else begin
//             state = TRIAL;
//         end
//     end
//     else begin
//         state = boost;
//     end




// end






reg need_to_deduct_in_THIS_cycle = 0;
reg deduct_ena = 0;

// Play
always @( posedge clk or negedge rst_n )
begin
    if (!rst_n)
    begin
        // reamin_reg = 0;
        trial_count = 1;
        trial_time_spent = 0;
        // first_minute = 0;
        need_to_deduct_in_THIS_cycle = 0;
        deduct_ena = 0;

    end

    else
    begin
        




        // // Judge State

        // if ( boost == TRIAL )
        // begin
        //     if ( trial_count > 0 )
        //     begin
        //         state = TRIAL;
        //     end
        //     else
        //         state = state;

        // end
        // else
        // begin        
        // // If just changed the state, then skip one deduction in the first clock peroid.

        //         state = boost;
       
        // end








        // Play

            // case (state)
            //     IDLE:
            //     begin
            //         ;



            //     end

            //     NORMAL:
            //     begin
            //     if ( reamin_reg >= 1 )
            //             reamin_reg = reamin_reg - cost_per_minute;




            //     end

            //     PLAY:
            //     begin

            //             if ( reamin_reg >= 2 ) begin

            //                     reamin_reg = reamin_reg - cost_per_minute;

            //             end

            //     end

            //     TRIAL:
            //     begin

            //         reamin_reg = reamin_reg;

            //         if (trial_time_spent == TRIAL_mode_time_limit)
            //         begin
            //             ;
            //             state = NORMAL;
            //             trial_count = trial_count - 1;
            //             trial_time_spent = 0;
            //         end
            //         else
            //         begin
            //             trial_time_spent = trial_time_spent + 1;
            //         end


            //     end

            //     default: 
            //     begin
            //         state = IDLE;
            //     end

            // endcase
            

            // 2. 状�?�转移�?�辑
        case (state)
            IDLE: begin
                if (boost == NORMAL) state = NORMAL;
                else if (boost == PLAY) state = PLAY;
                else if (boost == TRIAL && trial_count > 0) state = TRIAL;
            end
            
            NORMAL: begin
                if (boost == PLAY) state = PLAY;
                else if (boost == TRIAL && trial_count > 0) state = TRIAL;
                else if (boost == IDLE) state = IDLE;
            end
            
            PLAY: begin
                if (boost == NORMAL) state = NORMAL;
                else if (boost == TRIAL && trial_count > 0) state = TRIAL;
                else if (boost == IDLE) state = IDLE;
            end
            
            TRIAL: begin
                if (trial_time_spent == TRIAL_mode_time_limit) begin
                    state = NORMAL;          // 时间到切回NORMAL
                    trial_count = trial_count - 1; // 消�?�试用次�?
                    trial_time_spent = 0;
                end
                else begin
                    trial_time_spent = trial_time_spent + 1;
                end
            end
        endcase






    
        //////////////////////////////
        need_to_deduct_in_THIS_cycle = ( (state == NORMAL && reamin_reg >= 1) || (state == PLAY && reamin_reg >= 2) ) ? 1 : 0;
        deduct_ena <= need_to_deduct_in_THIS_cycle;
        // You must place the block above before the update of the corresponding variables
        // in the SAME always block.
        // Or the variables in two always blocks can not be synchronously changed in one posedgeCLK.
        // Note that the first assignment is blocking assignment, while the second is non-blocking assignment.
        // I don't know the exact reason why these two assignments should be ordered like this way.
        // But up to now, I haven't found problems when applying this method in the 2023.1 and 2024.2 tests.
        //////////////////////////////
    






        // 3. 扣费逻辑（基于当前state，不是新状�?�！�?
        if (deduct_ena) begin
            case (state)
                NORMAL: begin
                    if (reamin_reg >= 1) reamin_reg <= reamin_reg - 1; // 固定费率1
                end
                PLAY: begin
                    if (reamin_reg >= 2) reamin_reg <= reamin_reg - 2; // 固定费率2
                end
                // IDLE/TRIAL 不扣�?
                default: reamin_reg <= reamin_reg;
            endcase
        end












    end // rst_n else

end









endmodule
