// 定义模块和端口
module traffic_button_ctrl(
    input        clk,
    input        rst_n,
    input        ped_btn,
    output reg [1:0] main_light,  // 0:Green, 1:Yellow, 2:Red
    output reg [1:0] ped_light    // 0:Red, 1:Green
);


    parameter S_IDLE   = 2'b00; 
    localparam S_GREEN  = 2'b01; 
    localparam S_YELLOW = 2'b10; 


    localparam GREEN_DURATION  = 10;
    localparam YELLOW_DURATION = 3;
    localparam RED_DURATION    = 10;
    localparam COOLDOWN_DURATION = 18;


    reg [1:0] current_state;
    reg [1:0] next_state;
    
    reg [4:0] state_timer;      
    reg [4:0] cool_down_timer;  

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_state <= S_IDLE;
        end else begin
            current_state <= next_state;
        end
    end


    always @(*) begin
        next_state = current_state; 
        
        case (current_state)
            S_IDLE: begin
              
                if (state_timer == RED_DURATION) begin
                    next_state = S_GREEN;
                end
            end
            
            S_GREEN: begin
               
                if (ped_btn && (cool_down_timer == 0)) begin
                    next_state = S_YELLOW;
                end
              
                else if (state_timer == GREEN_DURATION) begin
                    next_state = S_YELLOW;
                end
            end
            
            S_YELLOW: begin
                
                if (state_timer == YELLOW_DURATION) begin
                    next_state = S_IDLE;
                end
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_timer     <= 5'd0;
            cool_down_timer <= 5'd0;
        end else begin

            if (current_state != next_state) begin
                state_timer <= 5'd1; 
            end else begin
                state_timer <= state_timer + 5'd1; 
            end


            if (current_state == S_GREEN && ped_btn && cool_down_timer == 0) begin
     
                cool_down_timer <= COOLDOWN_DURATION;
            end else if (cool_down_timer > 0) begin
      
                cool_down_timer <= cool_down_timer - 5'd1;
            end
       
        end
    end


    always @(*) begin
        case (current_state)
            S_IDLE: begin
                main_light = 2'd2; 
                ped_light  = 2'd1; 
            end
            S_GREEN: begin
                main_light = 2'd0; 
                ped_light  = 2'd0; 
            end
            S_YELLOW: begin
                main_light = 2'd1; 
                ped_light  = 2'd0; 
            end
            default: begin 
                main_light = 2'd2;
                ped_light  = 2'd1;
            end
        endcase
    end

endmodule