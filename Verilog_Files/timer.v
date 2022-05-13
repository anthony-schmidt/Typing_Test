module timer(
	input clk,	
	input rst,
	output t
);
	
reg [26:0] count = 0;	

//assign t = (count == 27'd5000000);
assign t = (count == 27'd5000); // For Testbench

always @(posedge clk) begin
	if (rst | t)
		count <= 0;
	else 
		count <= count + 3'd1;
end

endmodule
