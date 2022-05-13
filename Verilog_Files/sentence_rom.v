module sentence_rom(
	input	[10:0] addr,
	output [7:0] dout
	);
	
	reg [7:0] mem_array [0:2047];
	
	//import from a file
	initial $readmemh("sentence_rom_data.txt", mem_array);
	
	assign dout = mem_array[addr];
	
endmodule

