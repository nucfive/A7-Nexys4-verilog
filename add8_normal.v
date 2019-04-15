`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 2019/03/20 00:00:32
// Design Name: 
// Module Name: add8_normal
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

module add8_normal(
	 input                      wire                     clk_100M
	,input                      wire                     rst
	,input                      wire                     cin
	,input                      wire         [7 : 0]     cina
	,input                      wire         [7 : 0]     cinb
	,output                     wire         [7 : 0]     sum
	,output                     wire                     cout
);
	reg [7 : 0] sum1;
	reg cout1;
	
	assign sum = sum1;
	assign cout = cout1;
	
	always @ (posedge clk_100M) begin : NORMAL_ADD
		if(rst) begin
			sum1 <= 8'b0000_0000;
			cout1 <= 1'b0;
		end else 
			{cout1, sum1} <= cin + cina + cinb;
	end
	
endmodule

