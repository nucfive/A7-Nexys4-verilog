`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/22 10:24:30
// Design Name: 
// Module Name: tb_shift
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


module tb_shift;
	reg clk_100M;
	reg rst;
	reg [7 : 0] data_in;
	wire [7 : 0] data_out;
	
	shift_reg U_shift_reg(
		.clk_100M(clk_100M),
		.rst(rst),
		.data_in(data_in),
		.data_out(data_out)	
	);
	
	initial begin
		clk_100M = 1'b0;
		rst = 1'b1;
		data_in = 8'b0;
		#132 rst = 1'b0;
		forever #20 data_in = {$random} % 256;
	end
	
	always #5 clk_100M = !clk_100M;
	
	initial #8000 $stop;

endmodule
