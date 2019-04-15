`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 00:09:42
// Design Name: 
// Module Name: tb
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


module tb;
	
	reg clk_100M;
	reg rst;
	reg cin;
	reg [7 : 0] cina;
	reg [7 : 0] cinb;
	wire [7 : 0] sum;
	wire cout;
	
	/*
	add8_pipeline U_add8_pipeline(
		.clk_100M(clk_100M),
		.rst(rst),
		.cin(cin),
		.cina(cina),
		.cinb(cinb),
		.sum(sum),
		.cout(cout)
	);
	*/
	add8_normal U_add8_normal(
		.clk_100M(clk_100M),
		.rst(rst),
		.cin(cin),
		.cina(cina),
		.cinb(cinb),
		.sum(sum),
		.cout(cout)
	);
	initial begin
		clk_100M = 1'b0;
		rst = 1'b1;
		cin = 1'b0;
		cina = 8'd255;
		cinb = 8'd100;
		#131.2 rst = 1'b0;
		#300 cina = 8'd100; cinb = 8'd100; cin = 1'b1;
		#300 cina = 8'd150; cinb = 8'd150; cin = 1'b1;
		#300 cina = 8'd200; cinb = 8'd100; cin = 1'b1;
		#300 cina = 8'd100; cinb = 8'd150; cin = 1'b1;
		#300 cina = 8'd100; cinb = 8'd100; cin = 1'b1;
		#300 cina = 8'd110; cinb = 8'd110; cin = 1'b1;
		#300 cina = 8'd105; cinb = 8'd130; cin = 1'b1;
		#300 cina = 8'd100; cinb = 8'd104; cin = 1'b1;
		#300 cina = 8'd90; cinb = 8'd120; cin = 1'b1;
	end

	always #10 clk_100M = !clk_100M;
	
	initial #20000 $stop;
	
endmodule
