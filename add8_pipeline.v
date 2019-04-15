`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/19 23:49:05
// Design Name: 
// Module Name: add8_pipeline
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 	二级流水线设计8bit带进位加法器
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module add8_pipeline(
	 input                      wire                     clk_100M
	,input                      wire                     rst
	,input                      wire                     cin
	,input                      wire         [7 : 0]     cina
	,input                      wire         [7 : 0]     cinb
	,output                     wire         [7 : 0]     sum
	,output                     wire                     cout
);
	reg [3 : 0] sum1;
	reg [7 : 0] sum_temp;
	reg cout1;
	reg cout2;
	
	assign cout = cout2;
	assign sum = sum_temp;
	
	always @ (posedge clk_100M) begin : FIRST_PIPLINE
		if(rst) begin
			sum1 <= 4'b0000;
			cout1 <= 1'b0;
		end else 
			{cout1, sum1} <= cin + cina[3 : 0] + cinb[3 : 0];
	end
	
	always @ (posedge clk_100M) begin : SECOND_PIPLINE
		if(rst) begin
			sum_temp <= 8'b0000_0000;
			cout2 <= 1'b0;
		end else 
			{cout2, sum_temp} <= {{cina[7], cina[7 : 4]} + {cinb[7], cinb[7 : 4] + cout1}, sum1};
	end
	
endmodule
