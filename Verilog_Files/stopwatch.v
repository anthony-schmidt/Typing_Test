module stopwatch(
	input clk,
	input rst,
	input start,
	output reg at_end,
	output [3:0] deciseconds_out,
	output [3:0] seconds_out,
	output [3:0] decaseconds_out
);

wire t_wire;
integer internal_time;
reg [31:0] deciseconds;
reg [31:0] seconds;
reg [31:0] decaseconds;

assign deciseconds_out = deciseconds[3:0];
assign seconds_out = seconds[3:0];
assign decaseconds_out = decaseconds[3:0];

timer timer_0(
	.clk(clk),
	.rst(rst),
	.t(t_wire)
);


always @(posedge clk) begin
	if (rst)
		internal_time <= 0;
	else if(internal_time == 999)
		internal_time <= internal_time;
	else if(t_wire && start)
		internal_time <= internal_time + 1;
	else if (~start)
		internal_time <= internal_time;
end

always @(posedge clk) begin
	if(internal_time == 999)
		at_end <= 1;
	else
		at_end <= 0;
end

always @(posedge clk) begin
	deciseconds <= internal_time % 10;
end

always @(posedge clk) begin
	seconds <= (((internal_time - deciseconds)  % 100) / 10);
end

always @(posedge clk) begin
	decaseconds <= (((internal_time - seconds - deciseconds)  % 1000) / 100);
end

endmodule
