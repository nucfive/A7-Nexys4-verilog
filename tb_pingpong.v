`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 17:27:42
// Design Name: 
// Module Name: tb_pingpong
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
module tb_pingpong;
	reg clk_100;
	reg rst;
	reg start;
	wire [3 : 0] douta_b;
	wire [3 : 0] doutb_b;
	
	ping_pong U_ping_pong(
		.clk_100(clk_100),
		.rst(rst),
		.start(start),
		.douta_b(douta_b),
		.doutb_b(doutb_b)
	);
	
	initial begin 
		clk_100 = 1'b0;
		rst = 1'b1;
		start = 1'b0;
		#135 rst = 1'b0;
		#75 start = 1'b1;
	end
	
	always #10 clk_100 = !clk_100; 
	
	initial #30000 $stop;
	
endmodule
