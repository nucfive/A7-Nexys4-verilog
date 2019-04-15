`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/20 15:43:06
// Design Name: 
// Module Name: ping_pong
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
module ping_pong(
	 input                  wire                     clk_100
	,input                  wire                     rst
	,input                  wire                     start
	,output                 wire      [3 : 0]        douta_b
	,output                 wire      [3 : 0]        doutb_b
);
	wire wea_a;
	wire wea_b;
	wire ena_a;
	wire ena_b;
	wire [3 : 0] douta_b_temp;
	wire [3 : 0] doutb_b_temp;
	reg [1 : 0] currnt_state;
	reg [10 : 0] addr;
	reg [3 : 0] din;
	reg [1 : 0] sel;
		
	localparam 	IDLE = 2'b00,
				WA_RB = 2'b01,
				WB_RA = 2'b10;
				
	assign wea_a = (currnt_state == WA_RB);
	assign ena_a = (currnt_state == WA_RB);
	assign wea_b = (currnt_state == WB_RA);
	assign ena_b = (currnt_state == WB_RA);
	assign douta_b = (sel[0]) ? douta_b_temp : 4'b0000;
	assign doutb_b = (sel[1]) ? doutb_b_temp : 4'b0000; 
	
	always @ (posedge clk_100) begin : FSM_1
		if(rst) begin
			currnt_state <= IDLE;
			addr <= 11'd0;
			din <= 4'd0;
		end else begin 
			case(currnt_state)
				IDLE	:	begin 
								if(start) 
									currnt_state = WA_RB;
								else 
									currnt_state = IDLE;
							end
							
				WA_RB	: 	begin
								if(addr < 11'd1023) begin
									currnt_state <= WA_RB;
									addr <= addr + 11'd1;
									din <= {$random} % 16;
								end else begin 
									currnt_state <= WB_RA;
									addr <= 11'd0;
								end
								
							end
							
				WB_RA 	: 	begin
								if(addr < 11'd1023) begin
									currnt_state <= WB_RA;
									addr <= addr + 11'd1;
									din <= {$random} % 16;
								end else begin 
									currnt_state <= WA_RB;
									addr <= 11'd0;
								end
							end
				default	: 	currnt_state <= IDLE;
			endcase	
		end
	end
	
	always @ (*) begin : CLEAR_A
		if(rst) 
			sel[0] = 1'b0;
		else if((wea_a && ena_a) == 1'b1) 
			sel[0] = 1'b1;
		else if((wea_a && ena_a) == 1'b0)
			sel[0] = 1'b0;
		else 
			sel[0] = sel[0];
	end
	
	always @ (*) begin : CLEAR_B
		if(rst) 
			sel[1] = 1'b0;
		else if((wea_b && ena_b) == 1'b1) 
			sel[1] = 1'b1;
		else if((wea_b && ena_b) == 1'b0)
			sel[1] = 1'b0;
		else 
			sel[1] = sel[1];
	end
	
	blk_mem_gen_A  U_blk_mem_gen_A (
		.clka(clk_100), //: IN STD_LOGIC;
		.ena(ena_a), //: IN STD_LOGIC;
		.wea(wea_a), //: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		.addra(addr), //: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		.dina(din), //: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		.clkb(clk_100), //: IN STD_LOGIC;
		.enb(ena_a), //: IN STD_LOGIC;
		.addrb(addr), //: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		.doutb(douta_b_temp) //: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

	blk_mem_gen_B  U_blk_mem_gen_B (
		.clka(clk_100), //: IN STD_LOGIC;
		.ena(ena_b), //: IN STD_LOGIC;
		.wea(wea_b), //: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		.addra(addr), //: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		.dina(din), //: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		.clkb(clk_100), //: IN STD_LOGIC;
		.enb(ena_b), //: IN STD_LOGIC;
		.addrb(addr), //: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		.doutb(doutb_b_temp) //: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

endmodule
