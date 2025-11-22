//鏁板瓧鏃堕挓璁℃暟鍣?
module digital_clock(
	input clk,
	input rst_n,
	input en,
	output [7:0] hour,
	output [7:0] min,
	output [7:0] sec,
//	output tweet
    output o_pm
	);
 
 
wire co_sec1,co_sec,co_min,co_min1;
wire co_hour,co_hour1 ;



counter60 inst_sec(.clk(clk), .rst_n(rst_n), .en(en), .dout(sec), .co(co_sec1));
and inst_and_sec(co_sec,en,co_sec1);
counter60 inst_min(.clk(clk), .rst_n(rst_n), .en(co_sec), .dout(min), .co(co_min1));
and inst_and_min(co_min,co_sec,co_min1);

//assign tweet = (min == 0)&&(sec == 0) ? 1 : 0; // report time signal 原来是整小时点报时功能

//counter24 inst_hour(.clk(clk), .rst_n(rst_n), .en(co_min), .dout(hour), .co() );
counter12 inst_hour(.clk(clk), .rst_n(rst_n), .en(co_min), .dout(hour), .co(co_hour1) );

and inst_and_12_hours( co_hour ,co_min , co_hour1 );

reg pm_counter = 0;

always @(posedge clk or negedge rst_n) begin
    if (co_hour == 1)
       pm_counter = pm_counter + 1;

    
end

assign o_pm = pm_counter;

 
endmodule
 