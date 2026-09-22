`timescale 1ns/1ns
`include "q1.v"

module q1_tb();
reg D, clk, reset;
wire Q;

q1 ex1(D, Q, reset, clk);

initial begin
	clk = 0;
	forever #20 clk = ~clk;
end

initial begin
	
	$dumpfile("q1_tb.vcd");
	$dumpvars(0,q1_tb);
	
	D = 1; reset = 1;
	#20;
	
	D = 0; reset = 1;
	#20;
	
	D = 1; reset = 0;
	#20;
	
	D = 0; reset = 0;
	#20;
	
	$finish;

end

endmodule
