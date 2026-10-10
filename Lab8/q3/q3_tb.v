`timescale 1ns/1ns
`include "q3.v"

module q3_tb();
reg clk, reset;
wire [4:0]a;

q3 ex1(a, clk, reset);

initial begin
	clk = 0;
	forever #10 clk = ~clk;
end

initial begin
	
	$dumpfile("q3_tb.vcd");
	$dumpvars(0,q3_tb);
	
	reset = 1; #20;
	
	reset = 0;
	#20;
	#20;
	#20;
	#20;

	reset = 1; #20;
	
	$finish;

end

endmodule
