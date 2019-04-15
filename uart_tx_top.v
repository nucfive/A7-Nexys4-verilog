`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/13 20:27:36
// Design Name: 
// Module Name: uart_tx_top
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
module uart_tx_top(
	 input                          wire                          sys_clk
	,input                          wire                          rst
	,input                          wire                          tx_start
	,input                          wire         [7 : 0]          data_in
	,output                         wire                          tx
);

	parameter 	N = 1302, 
				SAMPLE = 8;
				
	localparam 	IDLE = 2'b00,
				S_INIT = 2'b01,
				S_TRAN = 2'b11;
				
	reg [2 : 0] n_state, c_state;
	reg [10 : 0] cnt;
	reg [6 : 0] cnt_sample;
	reg cnt_en, tx_temp;
	assign tx = tx_temp;
	
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
			tx_temp = 1'b1;
		end else begin
			case (c_state)
				IDLE	:	begin 
								n_state = S_INIT;
								cnt_en = 1'b0;
								tx_temp = 1'b1;
							end
				
				S_INIT	:	begin 
								if(tx_start) begin
									n_state = S_TRAN;
									cnt_en = 1'b1;
									tx_temp = 1'b1;
								end else begin
									n_state = S_INIT;
									cnt_en = 1'b0;
									tx_temp = 1'b1;
								end				
							end
			
				S_TRAN	:	begin 
								case (cnt_sample)
									0	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = 1'b0;
											end
											
									8	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = data_in[0];
											end
											
									16	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = data_in[1];
											end
									
									24	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = data_in[2];
											end
									
									32	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = data_in[3];
											end
									
									40	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = data_in[4];
											end
									
									48	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = data_in[5];
											end
									
									56	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = data_in[6];
											end
									
									64	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = data_in[7];
											end
									
									72	:	begin
												n_state = S_TRAN;
												cnt_en = 1'b1;
												tx_temp = 1'b1;
											end
									
									80	:	begin
												n_state = S_INIT;
												cnt_en = 1'b0;
												tx_temp = 1'b1;
											end
									
									default	:	begin
													n_state = n_state;
													cnt_en = cnt_en;                                                              
													tx_temp = tx_temp;
												end
								endcase
							end
			
				default	:	begin
								n_state = S_INIT;
								cnt_en = 1'b0;
								tx_temp = 1'b1;
							end
			endcase
		end
	end

endmodule
