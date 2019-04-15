`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 15:43:43
// Design Name: 
// Module Name: doul_ram_test
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

module doul_ram_test(
	 input                            wire                    clk_100
	,input                            wire                    clk_50
	,input                            wire                    rst
	,output                           wire         [3 : 0]    data_out
);
	wire wea = 1'b1;
	wire ena = 1'b1;
	wire enb = 1'b1;
	reg [10 : 0] addra, addrb;
	reg [3 : 0] dina;
	
	doul_ram_4X256 U_doul_ram_4X256 (
		.clka(clk_100), //: IN STD_LOGIC;
		.ena(ena), //: IN STD_LOGIC;
		.wea(wea), //: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		.addra(addra), //: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		.dina(dina), //: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		.clkb(clk_50), //: IN STD_LOGIC;
		.enb(enb), //: IN STD_LOGIC;
		.addrb(addrb), //: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		.doutb(data_out) //: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
	
	always @ (posedge clk_100) begin : PortA_addra
		if(rst)
			addra <= 10'd0;
		else 
			addra <= addra + 10'd1;
	end
	
	always @ (posedge clk_100) begin : data_generator
		if(rst)
			dina <=  4'd0;
		else 
			dina <= {$random} % 16;
	
	end
	
	always @ (posedge clk_50) begin : PortB_addrb 
		if(rst)
			addrb <= 10'd0;
		else 
			addrb <= addrb + 10'd1;
	end
	
endmodule
