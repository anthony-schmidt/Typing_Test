module controller(
	input clk,
	output reg en_curr_addr,
	output reg [1:0] s_curr_addr,
	output reg en_stopwatch_rst,
	output reg s_stopwatch_rst,
	output reg en_stopwatch_start,
	output reg s_stopwatch_start,
	output reg en_out_byte,
	output reg [1:0] s_out_byte,
	output reg en_uart_tx_go,
	output reg s_uart_tx_go,
	input tx_done,
	input reset_eq_0,
	input uart_pressed_eq_1,
	input start_of_game,
	input rom_eq_uart,
	input end_of_game,
	input stopwatch_start_eq_0_and_rom_eq_0,
	input stopwatch_start_eq_0_and_rom_ne_0
	);

parameter WAIT = 4'h0;
parameter INIT = 4'h1;
parameter SEND_ROM_BYTE = 4'h2;
parameter CHECK_VALID = 4'h3;
parameter CHECK_VS_MEM = 4'h4;
parameter SEND_USER_BYTE = 4'h5;
parameter INC_MEM = 4'h6;
parameter CHECK_END = 4'h7;
parameter FINISH = 4'h8;

reg [3:0] state;
reg [3:0] next_state;

always @(posedge clk) begin
	if(reset_eq_0)
		state <= next_state;
	else 
		state <= WAIT;
end

always @(*) begin
	en_curr_addr = 0;
	s_curr_addr = 0;
	en_stopwatch_rst = 0;
	s_stopwatch_rst = 0;
	en_stopwatch_start = 0;
	s_stopwatch_start = 0;
	en_out_byte = 0;
	s_out_byte = 0;
	en_uart_tx_go = 1;
	s_uart_tx_go = 0;
	
	next_state = INIT;
	case(state)
		WAIT: begin
			en_stopwatch_rst = 1;
			s_stopwatch_rst = 1;
			en_stopwatch_start = 1; 
			s_stopwatch_start = 0;
			en_curr_addr = 1;
			s_curr_addr = 0;
			
			if(start_of_game)
				next_state = SEND_ROM_BYTE;
			else
				next_state = WAIT;
		end
		
		INIT: begin
			en_stopwatch_rst = 1;
			s_stopwatch_rst = 0;
			en_stopwatch_start = 1;
			s_stopwatch_start = 1;
			en_curr_addr = 1;
			s_curr_addr = 0;
			en_uart_tx_go = 1;
			s_uart_tx_go = 1;
			en_out_byte = 1;
			s_out_byte = 0;
	
			if(tx_done)
				next_state = INC_MEM;
			else
				next_state = INIT;
	
		end
		
		SEND_ROM_BYTE: begin
			en_out_byte = 1;
			s_out_byte = 1;
			en_uart_tx_go = 1;
			s_uart_tx_go = 1;
			en_curr_addr = 1;
			s_curr_addr = 2;
			
			if(tx_done)
				next_state = INC_MEM;
			else
				next_state = SEND_ROM_BYTE;
		end
		
		CHECK_VALID: begin
			if(uart_pressed_eq_1) 
				next_state = SEND_USER_BYTE;
			else
				next_state = CHECK_VALID;
		end
		CHECK_VS_MEM: begin
			en_uart_tx_go = 1;
			s_uart_tx_go = 0;
			if(rom_eq_uart)
				next_state = INC_MEM;
			else
				next_state = FINISH;
		end
		
		SEND_USER_BYTE: begin
			en_out_byte = 1;
			s_out_byte = 2;
			en_uart_tx_go = 1;
			s_uart_tx_go = 1;
			
			next_state = CHECK_VS_MEM;
		end
		
		INC_MEM: begin
			en_curr_addr = 1;
			s_curr_addr = 1;	
	
			next_state = CHECK_END;
		end
		
		CHECK_END: begin
			if(stopwatch_start_eq_0_and_rom_eq_0)
				next_state = INIT;
			else if(stopwatch_start_eq_0_and_rom_ne_0)
				next_state = SEND_ROM_BYTE;
			else if(end_of_game)
				next_state = FINISH;
			else 
				next_state = CHECK_VALID;
		end
		
		FINISH: begin
			en_stopwatch_start = 1;
			s_stopwatch_start = 0;
			
			next_state = FINISH;
		end
		
		default: ;
	endcase
end

endmodule

