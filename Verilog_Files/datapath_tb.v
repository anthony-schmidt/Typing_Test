`timescale 1ns/1ns

module datapath_tb();
reg clk;
reg rst;
reg [7:0] dout;
reg [7:0] w_RX_Byte;
reg w_RX_DV;
reg en_curr_addr;
reg [1:0] s_curr_addr;
reg en_stopwatch_rst;
reg s_stopwatch_rst;
reg en_stopwatch_start;
reg s_stopwatch_start;
reg en_out_byte;
reg [1:0] s_out_byte;
reg en_uart_tx_go;
reg s_uart_tx_go;
wire [10:0] rom_addr_out;
wire [7:0] out_byte;
wire uart_tx_go;
wire reset_eq_0;
wire uart_pressed_eq_1;
wire start_of_game;
wire rom_eq_uart;
wire end_of_game;
wire stopwatch_start_eq_0_and_rom_eq_0;
wire stopwatch_start_eq_0_and_rom_ne_0;
wire [3:0] deciseconds_out;
wire [3:0] seconds_out;
wire [3:0] decaseconds_out;


always
	#5 clk = ~clk;
	
datapath uut(
	.clk(clk),
	.rst(rst),
	.dout (dout),
	.w_RX_Byte(w_RX_Byte),
	.w_RX_DV(w_RX_DV),
	.en_curr_addr(en_curr_addr),
	.s_curr_addr(s_curr_addr),
	.en_stopwatch_rst(en_stopwatch_rst),
	.s_stopwatch_rst(s_stopwatch_rst),
	.en_stopwatch_start(en_stopwatch_start),
	.s_stopwatch_start(s_stopwatch_start),
	.en_out_byte(en_out_byte),
	.s_out_byte(s_out_byte),
	.en_uart_tx_go(en_uart_tx_go),
	.s_uart_tx_go(s_uart_tx_go),
	.rom_addr_out(rom_addr_out),
	.uart_tx_go (uart_tx_go),
	.out_byte(out_byte),
	.reset_eq_0(reset_eq_0),
	.uart_pressed_eq_1(uart_pressed_eq_1),
	.start_of_game(start_of_game),
	.rom_eq_uart(rom_eq_uart),
	.end_of_game(end_of_game),
	.stopwatch_start_eq_0_and_rom_eq_0(stopwatch_start_eq_0_and_rom_eq_0),
	.stopwatch_start_eq_0_and_rom_ne_0(stopwatch_start_eq_0_and_rom_ne_0),
	.deciseconds_out(deciseconds_out),
	.seconds_out(seconds_out),
	.decaseconds_out(decaseconds_out)
);

initial begin
clk = 0; rst = 1; dout = 8'h00; w_RX_Byte = 8'h00; w_RX_DV = 0; en_curr_addr = 0; s_curr_addr = 2'd0; en_stopwatch_rst = 0; s_stopwatch_rst = 0; 
en_stopwatch_start = 0; s_stopwatch_start = 0; en_out_byte = 0; s_out_byte = 0; en_uart_tx_go = 1; s_uart_tx_go = 0;

	#10000 rst = 1; dout = 8'h0d; w_RX_Byte = 8'h00; w_RX_DV = 0; en_curr_addr = 1; s_curr_addr = 2'd0; en_stopwatch_rst = 1; s_stopwatch_rst = 1; 
en_stopwatch_start = 1; s_stopwatch_start = 0; en_out_byte = 0; s_out_byte = 0; en_uart_tx_go = 1; s_uart_tx_go = 0;

	#10000 rst = 1; dout = 8'h4a; w_RX_Byte = 8'h0d; w_RX_DV = 1; en_curr_addr = 1; s_curr_addr = 2'd2; en_stopwatch_rst = 0; s_stopwatch_rst = 0; 
en_stopwatch_start = 0; s_stopwatch_start = 0; en_out_byte = 1; s_out_byte = 1; en_uart_tx_go = 1; s_uart_tx_go = 1;

	#20000 dout = 8'h00; w_RX_Byte = 8'h54; w_RX_DV = 0; en_curr_addr = 0; s_curr_addr = 2'd0; en_stopwatch_rst = 0; s_stopwatch_rst = 0; 
en_stopwatch_start = 0; s_stopwatch_start = 0; en_out_byte = 0; s_out_byte = 0; en_uart_tx_go = 1; s_uart_tx_go = 1;

	#10000 en_stopwatch_start = 1; s_stopwatch_start = 1; en_stopwatch_rst = 1; s_stopwatch_rst = 0; 
	#500000;
	#10000 $stop;
end
endmodule
