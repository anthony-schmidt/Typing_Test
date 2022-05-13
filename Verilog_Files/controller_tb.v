`timescale 1ns/1ns

module controller_tb();
reg clk;
reg tx_done;
reg reset_eq_0;
reg uart_pressed_eq_1;
reg start_of_game;
reg rom_eq_uart;
reg end_of_game;
reg stopwatch_start_eq_0_and_rom_eq_0;
reg stopwatch_start_eq_0_and_rom_ne_0;
wire en_curr_addr;
wire [1:0] s_curr_addr;
wire en_stopwatch_rst;
wire s_stopwatch_rst;
wire en_stopwatch_start;
wire s_stopwatch_start;
wire en_out_byte;
wire [1:0] s_out_byte;
wire en_uart_tx_go;
wire s_uart_tx_go;

always 
	#5 clk = ~clk;
	
controller uut(
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

initial begin	
		clk = 0; tx_done = 0; reset_eq_0 = 0; uart_pressed_eq_1 = 0; start_of_game = 0; rom_eq_uart = 0; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 0;
		
	#10000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 0; start_of_game = 0; rom_eq_uart = 0; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 1;
	
	#10 start_of_game = 1;
		
	#10000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 0; start_of_game = 0; rom_eq_uart = 0; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 1;
		
	#20000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 1; start_of_game = 0; rom_eq_uart = 0; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 0;
		
	#10000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 1; start_of_game = 0; rom_eq_uart = 1; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 0;
		
	#20000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 1; start_of_game = 0; rom_eq_uart = 0; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 0;
		
	#10000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 1; start_of_game = 1; rom_eq_uart = 1; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 0;
	
	#10000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 1; start_of_game = 1; rom_eq_uart = 1; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 1; stopwatch_start_eq_0_and_rom_ne_0 = 0;
	
	
	#10000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 1; start_of_game = 1; rom_eq_uart = 1; end_of_game = 0; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 1;
	
		#10000 tx_done = 1; reset_eq_0 = 1; uart_pressed_eq_1 = 1; start_of_game = 1; rom_eq_uart = 1; end_of_game = 1; 
		stopwatch_start_eq_0_and_rom_eq_0 = 0; stopwatch_start_eq_0_and_rom_ne_0 = 1;
	#10000 $stop;
end	
endmodule