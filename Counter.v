`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/01/25 15:15:09
// Design Name: 
// Module Name: Counter
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
module Counter(
	 input                    wire                    clk_100M
	,input                    wire                    rst
	,input                    wire                    counter_en
	,output                   wire        [3:0]       counter   
    );
	
	reg [3:0] cnt;
	//RTL
	assign counter[3] = cnt[3];
	assign counter[2] = cnt[2];
	assign counter[1] = cnt[1];
	assign counter[0] = cnt[0];
	//Behavioral
	always @ (posedge clk_100M) begin : COUNTER
		if(rst) 
			cnt <= 4'd0;
		else if(counter_en) 
			cnt <= cnt + 4'd1;
		else 
			cnt <= cnt;
	end
endmodule
