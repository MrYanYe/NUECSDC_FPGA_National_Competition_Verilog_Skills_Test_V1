`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/27 18:35:19
// Design Name: 
// Module Name: add
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


module add( 
    input clk,//系统时钟 
    input rst_n,//系统复位，低电平有效 
    input [3:0] i_data,//数据输入口（最高位是符号位）大小：-8~+7范围有符号数 
    input valid,//数据有效（高有效） 
    output [5:0] o_data,//输出数据口（最高位是符号位） 
    output o_ready//输出数据有效 
); 
//coding 

// 每个累加期输入-8~+7 范围有符号数 i_data 共 4 个，i_valid 在输入数据有效时置
// 高，无效时置低，当接收到 4 个数据后，进行有符号数累加运算并输出累加结果
// o_data，同时拉高o_ready 线（此时也可以接收下一轮数据的输入）。o_ready拉高
// 一个时钟周期脉冲表明一次有效累加输出。

reg [2:0] count = 0;

// wire signed [3:0] i_data_signed ;
// assign i_data_signed = i_data;

reg valid_delay = 0;


parameter IN_WIDTH  = 4;
parameter OUT_WIDTH = 6;

wire signed [5:0] i_data_sext_wire;      // signed extended

reg [5:0] i_data_sext_1 = 0;
reg [5:0] i_data_sext_2 = 0;
reg [5:0] i_data_sext_delay = 0;


always @(*) begin
    i_data_sext_2 = i_data_sext_wire;
end

twos_complement
#(
    .IN_WIDTH(IN_WIDTH),   // 配置输入位宽
    .OUT_WIDTH(OUT_WIDTH)  // 配置输出位宽
)
u1_twos_complement
(
    .din(i_data),  // 连接输入原码
    .dout(i_data_sext_wire)  // 连接输出补码
);


// // 3. 实例化补码模块
// twos_complement
// #(
//     .IN_WIDTH(IN_WIDTH),   // 配置输入位宽
//     .OUT_WIDTH(OUT_WIDTH)  // 配置输出位宽
// )
// u_twos_complement
// (
//     .din(din),  // 连接输入原码
//     .dout(dout)  // 连接输出补码
// );








reg signed [5:0] o_data_sexd = 0;

// If the output is negative, convert it to sign‑magnitude representation.
twos_complement
#(
    .IN_WIDTH(OUT_WIDTH),   // 配置输入位宽
    .OUT_WIDTH(OUT_WIDTH)  // 配置输出位宽
)
u2_twos_complement
(
    .din(o_data_sexd),  // 连接输入补码
    .dout(o_data)  // 连接输出原码
);

// assign o_data = o_data_sexd;

reg signed [5:0] sum = 0;

reg o_ready_reg = 0;
assign o_ready = o_ready_reg;



reg set_o_data_to_high_in_THIS_cycle;
reg o_data_change_ena;
reg signed [5:0] sum_temp = 0;
reg signed [5:0] sum_in_THIS_cycle = 0;

reg [5:0] sum1=0;
reg [5:0] sum2=0;

always @(negedge clk or negedge rst_n) begin
    ;
    if ( !rst_n ) begin
        count = 0;
        o_data_sexd = 0;
        o_ready_reg = 0;
        sum = 0;
    end
    else begin
        ;
        o_ready_reg = 0;
        o_data_sexd = 0;
        // set_o_data_to_high_in_THIS_cycle = 0;


        if (valid_delay) begin
            ;
            count = count + 1;
            // if ( count == 4 ) begin
            //     set_o_data_to_high_in_THIS_cycle <= 1 ;
            //     o_data_change_ena = set_o_data_to_high_in_THIS_cycle;
            // end
            // else begin
            //     ;
            //     o_data_sexd = o_data_sexd + i_data_sext;
            // end // if ( count == 4 )


            // sum = sum + i_data_sext;
            if ( count == 4 ) begin
                ;
            end



        end // if (valid)

            // Both o_ready and o_data will output in the cycle after the fourth number input.
                // set_o_data_to_high_in_THIS_cycle = ( count == 4 ) ;
                // o_data_change_ena = set_o_data_to_high_in_THIS_cycle;


                // sum_in_THIS_cycle = sum;
                // sum_temp = sum_in_THIS_cycle;

                // if (o_data_change_ena) begin

                // asynchronous reset
                if (count == 4) begin
                    ;
                    o_data_sexd = sum;
                    o_ready_reg = 1;


                    sum = 0;
                    count = 0;
                end

                // if ( count == 4 ) begin
                //     count = 0;
                // end






    end // else if ( !rst_n )
    

end














reg valid_1 = 0;
reg valid_2 = 0;
always @(negedge clk or negedge rst_n) begin
    if (!rst_n) begin
        valid_1 <= 0;
        // valid_2 <= 0;
        valid_delay <= 0;
    end
    else begin
        valid_1 <= valid;
        valid_delay = valid_1;
    end

end








always @(negedge clk or negedge rst_n) begin
    ;
    if (!rst_n) begin
        sum1 <= 0;
        sum2 <= 0;
        sum <= 0;
    end
    else begin
        i_data_sext_1 = i_data_sext_2;
        i_data_sext_delay = i_data_sext_1;
    end
end
// Make i_data_sext delay for one cycle



always @(negedge clk or negedge rst_n) begin
    ;
    if (!rst_n) begin
        ;
    end
    else begin
        if (valid_delay)
            sum = sum + i_data_sext_delay;
    end
end






endmodule 
