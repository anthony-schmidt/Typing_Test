`timescale 1ns/1ns
module stopwatch_tb();
reg clk;	
reg rst;
reg start;
wire at_end;
wire [3:0] deciseconds_out;
wire [3:0] seconds_out;
wire [3:0] decaseconds_out;

stopwatch uut(
	.clk(clk),
	.rst(rst),
	.start(start),
	.at_end(at_end),
	.deciseconds_out(deciseconds_out),
	.seconds_out(seconds_out),
	.decaseconds_out(decaseconds_out)
);


always
	#5 clk = ~clk;

initial begin
	clk = 0; rst = 1; start = 0;
	#10 rst = 0;
	#10 start = 1;
	#100000 start = 0;
	#100000 start = 1;
	#100000000 $stop;
end

endmodule
