`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/22 10:11:56
// Design Name: 
// Module Name: shift_reg
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
module shift_reg(
	 input                        wire                          clk_100M
   	,input                        wire                          rst
	,input                        wire          [7 : 0]         data_in
	,output                       wire          [7 : 0]         data_out	
);
	reg[7 : 0] shift_r[3 : 0];
	
	assign data_out = shift_r[0];
	
	always @ (posedge clk_100M) begin : SHIFT_REG  
		shift_r[3] <= data_in;
		shift_r[2] <= shift_r[3];
		shift_r[1] <= shift_r[2];
		shift_r[0] <= shift_r[1];
	end
	
endmodule
