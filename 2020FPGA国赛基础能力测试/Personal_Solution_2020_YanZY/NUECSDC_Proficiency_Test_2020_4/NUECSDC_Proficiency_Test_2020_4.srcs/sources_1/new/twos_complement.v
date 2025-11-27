// 通用符号数原码转补码模块（支持任意输入/输出位宽）
// 输入：din - 符号数原码（最高位为符号位，0=正，1=负）
// 输出：dout - 补码（最高位为符号位）
// 参数：IN_WIDTH - 输入位宽，OUT_WIDTH - 输出位宽（建议OUT_WIDTH >= IN_WIDTH避免溢出）
module twos_complement
#(
    parameter IN_WIDTH  = 4,    // 默认输入位宽：4位
    parameter OUT_WIDTH = 6     // 默认输出位宽：6位
)
(
    input  [IN_WIDTH-1:0]  din,  // 输入：符号数原码
    output [OUT_WIDTH-1:0] dout  // 输出：补码
);

    // 参数检查
    initial begin
        if (IN_WIDTH < 2) $fatal(1, "IN_WIDTH must be >= 2");
        if (OUT_WIDTH < IN_WIDTH) $fatal(1, "OUT_WIDTH must be >= IN_WIDTH");
    end


// 步骤1：计算输入原码对应的IN_WIDTH位补码
wire [IN_WIDTH-1:0] temp_complement;

assign temp_complement = ( din[IN_WIDTH-1] == 1 ) ? {din[IN_WIDTH-1], (~din[IN_WIDTH-2:0]) + 1'b1} : din;  // 符号位不变，数值位取反+1


// 步骤2：符号扩展/截断到OUT_WIDTH位
// 若OUT_WIDTH >= IN_WIDTH：高位补符号位（保持补码特性）
// 若OUT_WIDTH < IN_WIDTH：截断高位（可能溢出，不推荐）
assign dout = (OUT_WIDTH >= IN_WIDTH) ? 
              {{( OUT_WIDTH - IN_WIDTH ){din[IN_WIDTH-1]}}, temp_complement} :  // 符号扩展
              temp_complement[OUT_WIDTH-1:0];  // 截断高位

endmodule








// // 补码模块测试文件（验证4位-7转6位补码）
// module tb_complementor;

// // 1. 配置参数（匹配需求：4位输入，6位输出）
// parameter IN_WIDTH  = 4;
// parameter OUT_WIDTH = 6;

// // 2. 信号定义
// reg [IN_WIDTH-1:0]  din;   // 输入原码
// wire [OUT_WIDTH-1:0] dout;  // 输出补码

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

// // 4. 测试激励（生成输入信号）
// initial begin
//     // 测试用例1：4位原码-7（1111）→6位补码111001
//     din = 4'b1111;  // 输入4位原码-7
//     #10;  // 等待10个时间单位
//     $display("输入4位原码：%b（十进制-7）", din);
//     $display("输出6位补码：%b（十进制-7，预期111001）", dout);

//     // 测试用例2：4位原码+5（0101）→6位补码000101（正数补码=原码）
//     din = 4'b0101;  // 输入4位原码+5
//     #10;
//     $display("\n输入4位原码：%b（十进制+5）", din);
//     $display("输出6位补码：%b（十进制+5，预期000101）", dout);

//     $finish;  // 结束仿真
// end

// endmodule