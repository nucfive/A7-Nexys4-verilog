`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 16:06:41
// Design Name: 
// Module Name: tb_ram
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

module tb_ram;
	reg clk_100;
	reg clk_50;
	reg rst;
	wire [3 : 0] data_out;
	doul_ram_test U_doul_ram_test(
		.clk_100(clk_100),
		.clk_50(clk_50),
		.rst(rst),
		.data_out(data_out)
	);
	
	initial begin 
		clk_100 = 1'b0;
		clk_50 = 1'b0;
		rst = 1'b1;
		#132 rst = 1'b0;
	end
	
	always #5 clk_100 = !clk_100;
	always #10 clk_50 = !clk_50;

	initial #3000 $stop;

endmodule
