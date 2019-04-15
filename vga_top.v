//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/15 12:57:25
// Design Name: 
// Module Name: vga_top
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
`timescale 1ns / 1ps
`include "I:\\vivadoVerilog\\Tutorials_verilog\\lesson12_vga\\Prj\\Code\\src\\parameter.v" // sim 
module vga_top(
	 input                            wire                        sys_clk
	,input                            wire                        rst
	,output                           wire                        vga_hs
	,output                           wire                        vga_vs
	,output                           wire       [11:0]           pixel_data
);

	reg [9 : 0] cnt_hs;
	reg [9 : 0] cnt_vs;
	reg [11 : 0] data_rgb;
	wire pixel_clk;
	wire hs0, vs0;
	/*
	wire vedio_active = ((cnt_hs > `H_Sync_Time + `H_Back_Porch + `H_Left_Border - 1)
							&& (cnt_hs < `H_Sync_Time + `H_Back_Porch + `H_Left_Border + `H_Addr_Time - 1)) 
							&& ((cnt_vs > `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1) 
							&& (cnt_vs < `V_Sync_Time + `V_Back_Porch + `V_Top_Border + `V_Addr_Time - 1)) ? 1'b1 : 1'b0;
	*/
	assign vga_hs = hs0;
	assign vga_vs = vs0;
	assign hs0 = (cnt_hs < `H_Sync_Time) ? 1'b1 : 1'b0;
	assign vs0 = (cnt_vs < `V_Sync_Time) ? 1'b1 : 1'b0;
	assign pixel_data = data_rgb;
	
	clk_wiz_0 U_clk_wiz_0 (
		// Clock out ports
		.clk_out1(pixel_clk),
		// Clock in ports
		.clk_in1(sys_clk)
	);
	
	always @ (posedge pixel_clk) begin : CNT_HS
		if(rst)
			cnt_hs <= 10'd0;
		else 
			cnt_hs <= (cnt_hs == `H_Total_Time - 1) ? 10'd0 : cnt_hs + 10'd1;
	end
	
	always @ (posedge pixel_clk) begin : CNT_VS
		if(rst)
			cnt_vs <= 10'd0;
		else if(cnt_hs == `H_Sync_Time - 1)
			cnt_vs <= (cnt_vs == `V_Total_Time - 1) ? 10'd0 : cnt_vs + 10'd1;
		else 
			cnt_vs <= cnt_vs;
	end
	// TEST
	always @ (*) begin
		if(rst) 
			data_rgb = 12'd0;
		else begin
			if((cnt_hs > `H_Sync_Time + `H_Back_Porch + `H_Left_Border - 1) 
				&& (cnt_hs < `H_Sync_Time + `H_Back_Porch + `H_Left_Border + 320 - 1)
				&& (cnt_vs > `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1) 
				&& (cnt_vs < `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1 + 240))
				data_rgb = 12'd3840;//red
			else if((cnt_hs > `H_Sync_Time + `H_Back_Porch + `H_Left_Border + 320 - 1) 
				&& (cnt_hs < `H_Sync_Time + `H_Back_Porch + `H_Left_Border + 320 - 1 + 320)
				&& (cnt_vs > `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1) 
				&& (cnt_vs < `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1 + 240))
				data_rgb =  12'd240;//green
			else if((cnt_hs > `H_Sync_Time + `H_Back_Porch + `H_Left_Border - 1) 
				&& (cnt_hs < `H_Sync_Time + `H_Back_Porch + `H_Left_Border + 320 - 1)
				&& (cnt_vs > `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1 + 240) 
				&& (cnt_vs < `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1 + 240 + 240))
				data_rgb =  12'd15;// blue
			else if((cnt_hs > `H_Sync_Time + `H_Back_Porch + `H_Left_Border + 320 - 1) 
				&& (cnt_hs < `H_Sync_Time + `H_Back_Porch + `H_Left_Border + 320 + 320 - 1)
				&& (cnt_vs > `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1) 
				&& (cnt_vs < `V_Sync_Time + `V_Back_Porch + `V_Top_Border - 1 + 240 + 240))
				data_rgb = 12'd4095; //white
			else 
				data_rgb = 12'd0;
		end
	end
 
endmodule
