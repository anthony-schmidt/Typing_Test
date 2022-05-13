 module datapath(
	input clk,
	input rst,
	input [7:0] dout,
	input [7:0] w_RX_Byte,
	input w_RX_DV,
	input en_curr_addr,
	input [1:0] s_curr_addr,
	input en_stopwatch_rst,
	input s_stopwatch_rst,
	input en_stopwatch_start,
	input s_stopwatch_start,
	input en_out_byte,
	input [1:0] s_out_byte,
	input en_uart_tx_go,
	input s_uart_tx_go,
	output [10:0] rom_addr_out,
	output reg [7:0] out_byte,
	output reg uart_tx_go,
	output reset_eq_0,
	output uart_pressed_eq_1,
	output start_of_game,
	output rom_eq_uart,
	output end_of_game,
	output stopwatch_start_eq_0_and_rom_eq_0,
	output stopwatch_start_eq_0_and_rom_ne_0,
	output [3:0] deciseconds_out,
	output [3:0] seconds_out,
	output [3:0] decaseconds_out
);

reg [10:0] curr_addr;
assign rom_addr_out = curr_addr;

reg stopwatch_rst;
reg stopwatch_start;


wire at_end;

wire [11:0] w_chars_per_sec;

stopwatch stopwatch_0(
	.clk					(clk),
	.rst					(stopwatch_rst),
	.start				(stopwatch_start), 
	.at_end				(at_end),
	.deciseconds_out	(deciseconds_out),
	.seconds_out		(seconds_out),
	.decaseconds_out	(decaseconds_out)
);

assign reset_eq_0 = (rst == 1'd0);
assign uart_pressed_eq_1 = (w_RX_DV == 1'd1);
assign start_of_game = ((w_RX_DV == 1'd1) && (w_RX_Byte == 8'h0d));
assign rom_eq_uart = (w_RX_Byte == dout);
assign end_of_game = ((at_end == 1'd1) || (dout == 8'h00));
assign stopwatch_start_eq_0_and_rom_eq_0 = ((stopwatch_start == 0) && (dout == 8'h00));
assign stopwatch_start_eq_0_and_rom_ne_0 = ((stopwatch_start == 0) && (dout != 8'h00));


always @(posedge clk) begin
	if(en_curr_addr) begin
		if(s_curr_addr == 2'd1) 
			curr_addr <= curr_addr + 11'd1;
		else if(s_curr_addr == 2'd2)
			curr_addr <= curr_addr;
		else
			curr_addr <= 0;
	end
end

always @(posedge clk) begin
	if(en_stopwatch_rst) begin
		if(s_stopwatch_rst)
			stopwatch_rst <= 1;
		else
			stopwatch_rst <= 0;
		end
end

always @(posedge clk) begin
	if(en_stopwatch_start) begin
		if(s_stopwatch_start)
			stopwatch_start <= 1;
		else
			stopwatch_start <= 0;
	end
end

always @(posedge clk) begin
	if(en_out_byte) begin
		if(s_out_byte == 2'd0)
			out_byte <= 8'h0d;
		else if (s_out_byte == 2'd1)
			out_byte <= dout;
		else if(s_out_byte == 2'd2)
			out_byte <= w_RX_Byte;
	end
end

always @(posedge clk) begin
	if(en_uart_tx_go) begin
		if(s_uart_tx_go)
			uart_tx_go <= 1;
		else
			uart_tx_go <= 0;
	end
end

endmodule

