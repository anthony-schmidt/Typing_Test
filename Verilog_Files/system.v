module system(
	input clk,
	input rst,
	input w_RX_DV,
	input [7:0] w_RX_Byte,
	input tx_done, //from the tx uart, is 1 when transmission is complete
	output [7:0] out_byte,
	output uart_tx_go, //to the tx uart, is 1 when transmission should take place, assigned from the en_out_byte flag
	output [7:0] rom_out,
	output [3:0] deciseconds,
	output [3:0] seconds,
	output [3:0] decaseconds
);

wire en_curr_addr;
wire [1:0] s_curr_addr;
wire en_stopwatch_rst;
wire s_stopwatch_rst;
wire en_stopwatch_start;
wire s_stopwatch_start;
wire en_out_byte;
wire [1:0] s_out_byte;
wire reset_eq_0;
wire uart_pressed_eq_1;
wire start_of_game;
wire rom_eq_uart;
wire end_of_game;
wire stopwatch_start_eq_0_and_rom_eq_0;
wire stopwatch_start_eq_0_and_rom_ne_0;
wire [10:0]	addr_w;
wire [7:0] dout_w;
wire en_uart_tx_go;
wire s_uart_tx_go;
assign rom_out = dout_w;

sentence_rom sentence_rom_0(
	.addr		(addr_w),
	.dout		(dout_w)
);

datapath datapath_0(
	.clk(clk),
	.rst(rst),
	.dout (dout_w),
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
	.rom_addr_out(addr_w),
	.uart_tx_go (uart_tx_go),
	.out_byte(out_byte),
	.reset_eq_0(reset_eq_0),
	.uart_pressed_eq_1(uart_pressed_eq_1),
	.start_of_game(start_of_game),
	.rom_eq_uart(rom_eq_uart),
	.end_of_game(end_of_game),
	.stopwatch_start_eq_0_and_rom_eq_0(stopwatch_start_eq_0_and_rom_eq_0),
	.stopwatch_start_eq_0_and_rom_ne_0(stopwatch_start_eq_0_and_rom_ne_0),
	.deciseconds_out(deciseconds),
	.seconds_out(seconds),
	.decaseconds_out(decaseconds)
);


controller controller_0(
	.clk(clk),
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
	.tx_done(tx_done),
	.reset_eq_0(reset_eq_0),
	.uart_pressed_eq_1(uart_pressed_eq_1),
	.start_of_game(start_of_game),
	.rom_eq_uart(rom_eq_uart),
	.end_of_game(end_of_game),
	.stopwatch_start_eq_0_and_rom_eq_0(stopwatch_start_eq_0_and_rom_eq_0),
	.stopwatch_start_eq_0_and_rom_ne_0(stopwatch_start_eq_0_and_rom_ne_0)
);

endmodule

