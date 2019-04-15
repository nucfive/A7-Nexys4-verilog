`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/12 20:14:19
// Design Name: 
// Module Name: uart_rx_top
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
module uart_rx_top(
	 input                          wire                             sys_clk     // 125M
	,input                          wire                             rst
	,input                          wire                             rx
	//,output                         wire              [7 : 0]        data_rx
	//test
	,output                         wire              [7 : 0]        led_out
);
	parameter 	N = 1302, 
				SAMPLE = 8;
				
	localparam 	IDLE = 3'b000,
				S_INIT = 3'b001,
				S_CHECK = 3'b011,
				S_REV = 3'b010,
				S_STOP = 3'b110;
				
	reg [3 : 0] n_state, c_state;
	reg [10 : 0] cnt;
	reg [6 : 0] cnt_sample;
	reg [7 : 0] data_temp;
	reg rx_reg0, rx_reg1;
	reg cnt_en;
	reg [7 : 0] led;
	wire rx_start = ((!rx_reg0) && rx_reg1) ? 1'b1 : 1'b0;
	assign led_out = led;
	
	always @ (posedge sys_clk) begin : Rev
		if(rst) begin
			rx_reg0 <= 1'b1;
			rx_reg1 <= 1'b1;
		end else begin
			rx_reg0 <= rx;
			rx_reg1 <= rx_reg0;
		end	
	end
	
	
	always @ (posedge sys_clk) begin : CNT_SAMPLE
		if(rst || (cnt_en == 1'b0))
			cnt <= 11'd0;
		else if(cnt > N - 1) 
			cnt <= 11'd0;
		else if(cnt_en)
			cnt <= cnt + 11'd1;
		else 
			cnt <= cnt;
	end
	
	always @ (posedge sys_clk) begin : SAMPLE_CNT
		if(rst || (c_state == S_INIT))
			cnt_sample <= 7'd0;
		else if(cnt == N - 1) 
			cnt_sample <= cnt_sample + 7'd1;
		else 
			cnt_sample <= cnt_sample;
	end
	
	always @ (posedge sys_clk) begin : FSM_1
		if(rst)
			c_state <= IDLE;
		else 
			c_state <= n_state;
	end
	
	always @ (*) begin : FSM_2
		if(rst) begin
			n_state = IDLE;
			cnt_en = 1'b0;
			data_temp = 8'd0;
		end else begin
			case (c_state)
				IDLE	:	begin
								n_state = S_INIT;
								cnt_en = 1'b0;
								data_temp = 8'd0;
							end
				
				S_INIT	:	begin
								if(rx_start) begin
									n_state = S_CHECK;
									cnt_en = 1'b1;
									data_temp = data_temp;
								end else begin
									n_state = S_INIT;
									cnt_en = 1'b0;
									data_temp = data_temp;
								end
							end

				S_CHECK	:	begin
								if(cnt_sample == 4) begin
									if(rx == 0) begin
										n_state = S_REV;
										cnt_en = 1'b1;
										data_temp = data_temp;
									end else begin
										n_state = S_INIT;
										cnt_en = 1'b0;
										data_temp = data_temp;
									end								
								end else begin
									n_state = n_state;
									cnt_en = cnt_en;
									data_temp = data_temp;
								end				
							end
				S_REV	:	begin
								case (cnt_sample)
									12	: 	begin
												n_state = S_REV;
												cnt_en = 1'b1;
												data_temp[0] = rx;
											end
									20	: 	begin
												n_state = S_REV;
												cnt_en = 1'b1;
												data_temp[1] = rx;
											end
									28	: 	begin
												n_state = S_REV;
												cnt_en = 1'b1;
												data_temp[2] = rx;
											end
									36	: 	begin
												n_state = S_REV;
												cnt_en = 1'b1;
												data_temp[3] = rx;
											end
									44	: 	begin
												n_state = S_REV;
												cnt_en = 1'b1;
												data_temp[4] = rx;
											end
									52	: 	begin
												n_state = S_REV;
												cnt_en = 1'b1;
												data_temp[5] = rx;
											end
									60	: 	begin
												n_state = S_REV;
												cnt_en = 1'b1;
												data_temp[6] = rx;
											end
									68	: 	begin
												n_state = S_REV;
												cnt_en = 1'b1;
												data_temp[7] = rx;
											end
									76	: 	begin
												n_state = S_STOP;
												cnt_en = 1'b1;
												data_temp = data_temp;
											end
									default	: 	begin
													n_state = n_state;
													cnt_en = cnt_en;
													data_temp = data_temp;
												end
								endcase
							end
				
				S_STOP	:	begin
								if(rx) begin
									n_state = S_INIT;
									cnt_en = 1'b0;
									data_temp = data_temp;
								end else begin
									n_state = S_INIT;
									cnt_en = 1'b0;
									data_temp = 8'd0;
								end
							end
							
				default	: 	begin
								n_state = IDLE;
								cnt_en = 1'b0;
								data_temp = 8'd0;
							end
			endcase
		end	
	end
	
	// TEST 
	always @ (posedge sys_clk) begin : TEST
		if(rst) 
			led <= 8'd0;
		else 
			led <= data_temp;
	end
	
	
endmodule
