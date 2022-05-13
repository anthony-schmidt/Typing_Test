`timescale 1ns/1ns

module timer_tb();
reg clk;	
reg rst;
wire t;

timer uut(
	.clk(clk),
	.rst(rst),
	.t(t)
);


always
	#5 clk = ~clk;

initial begin
	clk = 0; rst = 1;
	#10 rst = 0;
	#100000000 $stop;
end

endmodule
