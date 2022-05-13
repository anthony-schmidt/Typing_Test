`timescale 1ns/1ns

module sentence_rom_tb();
	reg [10:0] addr;
	wire [7:0] dout;
	
	sentence_rom uut(
		.addr	(addr),
		.dout	(dout)
	);
	
	initial begin
				addr = 11'h000;
		#10	addr = 11'h001;
		#10	addr = 11'h002;
		#10	addr = 11'h003;
		#10	addr = 11'h07d;
		#10	addr = 11'h07e;
		#10	addr = 11'h07f;
		#10	$stop;
	
	end
	
endmodule


