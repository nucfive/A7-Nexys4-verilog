`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/14 15:49:53
// Design Name: 
// Module Name: uart_loop_top
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


module uart_loop_top(
	 input                           wire                         sys_clk
	,input                           wire                         rst
	,input                           wire                         rx
	,output                          wire                         tx
);
	reg tx_start;
	wire rx_finish;
	wire [7 : 0] data_in;
	
	always  @ (*) begin
		if(rst) 
			tx_start = 1'b0;
		else if(rx_finish)
			tx_start = 1'b1;
		else 
			tx_start = 1'b0;
	end
	
	uart_rx_top U_uart_rx_top(
		.sys_clk(sys_clk),     // 125M
		.rst(rst),
		.rx(rx),
		.data_rx(data_in),
		.rx_finish(rx_finish)
	);
	
	uart_tx_top U_uart_tx_top(
		.sys_clk(sys_clk),
		.rst(rst),
		.tx_start(tx_start),
		.data_in(data_in),
		.tx(tx)
	);

endmodule
