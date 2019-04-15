`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/28 15:24:59
// Design Name: 
// Module Name: led_breth
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


module led_breth(
	 input                  wire                         clk_100M
	,input                  wire                         rst
	,output                 wire                         led_out
);
	localparam N = 50000;
	reg [15 : 0] cnt1, cnt2;
	reg flag;
	
	always @ (posedge clk_100M) begin : CNT1
		if(rst) 
			cnt1 <= 16'd0;
		else if(cnt1 == N - 1) 
			cnt1 <=  16'd0;
		else 
			cnt1 <= cnt1 + 16'd1;
	end
	
	always @ (posedge clk_100M) begin : CNT2
		if(rst) 
			cnt2 <= 16'd0;
		else if(cnt1 == N - 1) 
			if(flag)
				cnt2 <= cnt2 + 16'd500;
			else 
				cnt2 <=  cnt2 - 16'd500;
		else 
			cnt2 <= cnt2;
	end
	
	always @ (posedge clk_100M) begin : FLAG
		if(rst) 
			flag <= 1'b1;
		else if(cnt2 >= N - 1) 
			flag <= 1'b0;
		else if(cnt2 <= 16'd0) 
			flag <= 1'b1;
		else 
			flag <= flag;
	end
	
	assign led_out = (cnt1 > cnt2) ? 1'b0 : 1'b1;
	
endmodule
