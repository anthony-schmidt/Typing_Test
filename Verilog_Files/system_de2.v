module system_de2(
	input CLOCK_50,
	input UART_RXD,
	input [0:0] SW,
	output UART_TXD,
	output [0:0] LEDG,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,
	output [6:0] HEX6,
	output [6:0] HEX7
);


wire [7:0] w_RX_Byte;
wire [7:0] w_TX_Byte;
wire w_RX_DV;
wire w_TX_Active, w_TX_Done, w_TX_Serial;
assign UART_TXD = o_UART_TX;
assign o_UART_TX = w_TX_Active ? w_TX_Serial : 1'b1; 


wire [3:0] hex_wire_0;
wire [3:0] hex_wire_2;
wire [3:0] hex_wire_3;
wire [7:0] rom_out;
wire [7:0] w_out_byte;
assign LEDG = SW;
wire uart_tx_go_w;

UART_RX #(.CLKS_PER_BIT(5208)) UART_RX_Inst (
	.i_Clock       (CLOCK_50),
	.i_RX_Serial   (UART_RXD),
	.o_RX_DV       (w_RX_DV),
	.o_RX_Byte     (w_RX_Byte)
);

UART_TX #(.CLKS_PER_BIT(5208)) UART_TX_Inst (
      .i_Clock       (CLOCK_50),
      .i_TX_DV       (uart_tx_go_w),
      .i_TX_Byte     (w_out_byte),
      .o_TX_Active   (w_TX_Active),
      .o_TX_Serial   (w_TX_Serial),
      .o_TX_Done     (w_TX_Done)
   );
	

system system_0(
	.clk        (CLOCK_50),
	.rst        (SW),
	.w_RX_DV    (w_RX_DV),
	.w_RX_Byte  (w_RX_Byte),
	.tx_done		(w_TX_Done),
	.out_byte   (w_out_byte),
	.deciseconds(hex_wire_0),
	.seconds    (hex_wire_2),
	.decaseconds(hex_wire_3),
	.rom_out    (rom_out),
	.uart_tx_go		(uart_tx_go_w)
);	

hexdigit hex_0(
	.in(hex_wire_0),
	.out(HEX0)
);

assign HEX1 = 7'b1110111;

hexdigit hex_2(
	.in(hex_wire_2),
	.out(HEX2)
);

hexdigit hex_3(
	.in(hex_wire_3),
	.out(HEX3)
);

hexdigit hex_4(
	.in(w_RX_Byte [3:0]),
	.out(HEX4)
);

hexdigit hex_5(
	.in(w_RX_Byte [7:4]),
	.out(HEX5)
);

hexdigit hex_6(
	.in(rom_out [3:0]),
	.out(HEX6)
);

hexdigit hex_7(
	.in(rom_out [7:4]),
	.out(HEX7)
);

endmodule

