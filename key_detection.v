`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/26 12:17:59
// Design Name: 
// Module Name: key_detection
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
module key_detection(
	 input                         wire                     clk_100M
	,input                         wire                     rst
	,input                         wire                     key_in
	,output                        wire                     led_out
);

	parameter 	N = 2000000;//tb : 200, normal :2000000;
	localparam 	S0 = 2'b00, // one-hot coding
				S1 = 2'b01,
				S2 = 2'b11,
				S3 = 2'b10;
	
	reg [20 : 0] cnt_20ms;
	reg led_reg;
	reg key_in0, key_in1;
	reg [1 : 0] n_state, c_state;
	wire cnt_en = ((c_state == S1) || (c_state == S3)) ? 1'b1 : 1'b0;
	wire key_en = key_in0 ^ key_in1; // key_en
	assign led_out = led_reg;
	
	always @ (posedge clk_100M) begin : KEY_DEC
		if(rst) begin
			key_in0 <= 1'b0;
			key_in1 <= 1'b0;
		end else begin
			key_in0 <= key_in;
			key_in1 <= key_in0;
		end
	end
	
	always @ (posedge clk_100M) begin : FSM_1
		if(rst)
			c_state <= S0;
		else 
			c_state <= n_state;
	end
	
	always @ (*) begin : FSM_2
		if(rst) begin
			n_state = S0;
		end else begin
			case(c_state) 
				S0	:	begin
							if(key_en) 
								n_state = S1;
							else 
								n_state = S0;
						end
				S1	:	begin
							if(cnt_20ms <= N - 1) 
								n_state = S1;
							else 
								n_state = S2;
						end
				S2	:	begin
							if(key_en) 
								n_state = S3;
							else 
								n_state = S2;
						end
				S3	:	begin
							if(cnt_20ms <= N - 1)
								n_state = S3;
							else 
								n_state = S0;
						end
			endcase
		end
	end
	
	always @ (*) begin : FSM_3
		if(rst) 
			led_reg = 1'b0;
		else begin 
			case(c_state)
				S0 	: ;
				S1 	: ;
				S2 	: led_reg = key_in1;
				S3 	: led_reg = key_in1;
			endcase
		end
	end
	
	always @ (posedge clk_100M) begin : CNT_20MS
		if(rst || (cnt_en == 1'b0))
			cnt_20ms <= 21'b0;
		else if(cnt_en == 1'b1) 
			cnt_20ms <= cnt_20ms + 21'b1;
		else 
			cnt_20ms <= cnt_20ms;
	end
	
endmodule
