`timescale 1ns/1ns

module system_tb();
reg clk;
reg rst;
reg w_RX_DV;
reg [7:0] w_RX_Byte;
reg tx_done; //from the tx uart, is 1 when transmission is complete
wire [7:0] rom_out;
wire uart_tx_go; //to the tx uart, is 1 when transmission should take place, assigned from the en_out_byte flag
wire [7:0] out_byte;
wire [3:0] deciseconds;
wire [3:0] seconds;
wire [3:0] decaseconds;

always 
	#5 clk = ~clk;
	
system uut(
	.clk(clk),
	.rst(rst),
	.w_RX_DV(w_RX_DV),
	.w_RX_Byte(w_RX_Byte),
	.tx_done(tx_done),
	.rom_out(rom_out),
	.uart_tx_go(uart_tx_go),
	.out_byte(out_byte),
	.deciseconds(deciseconds),
	.seconds(seconds),
	.decaseconds(decaseconds)
);

initial begin
		clk = 0; rst = 1;
	#10 rst = 0; tx_done = 0;
	while(rom_out != 8'h00)
		#10 tx_done = 0;
	#10 tx_done = 1; 
	#10000 w_RX_DV = 1; w_RX_Byte = 8'h0d;
	#10 w_RX_DV = 0;
	#40000 w_RX_DV = 1; w_RX_Byte = 8'h54;
	#10 w_RX_DV = 0;
	#40000 w_RX_DV = 1; w_RX_Byte = 8'h68;
	#10000 w_RX_DV = 1; w_RX_Byte = 8'h65;
	#10000 w_RX_DV = 1; w_RX_Byte = 8'h20;
	#10000 w_RX_DV = 1; w_RX_Byte = 8'h34;
	#10000 rst = 1;
	#10000 w_RX_DV = 1; w_RX_Byte = 8'h0d;
	#10000 $stop;
end

endmodule
