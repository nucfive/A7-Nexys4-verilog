`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 12:19:42
// Design Name: 
// Module Name: key_dection_tb
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
module key_dection_tb;
	reg clk_100M;
	reg rst;
	reg key_in;
	wire led_out;
	
	key_detection U_key_detection(
		.clk_100M(clk_100M),
		.rst(rst),
		.key_in(key_in),
		.led_out(led_out)
	);
	
	initial begin
		clk_100M = 1'b0;
		key_in = 1'b0;
		rst = 1'b1;
		#132 rst = 1'b0;
		#30000 key_in = 1'b1;
		#20 key_in = 1'b0;
		#30 key_in = 1'b1;
		#20 key_in = 1'b0;
		#30 key_in = 1'b1;
		#20000 key_in = 1'b0;
	end
	
	always #10 clk_100M = !clk_100M;
	initial #2000000 $stop;
		
endmodule
