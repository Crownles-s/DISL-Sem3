`timescale 1ns/1ns
`include "q3.v"

module q3_tb();
reg J, K, clk, reset;
wire Q;

q3 ex1(J, K, Q, reset, clk);

initial begin
	clk = 0;
	forever #20 clk = ~clk;
end

initial begin
	
	$dumpfile("q3_tb.vcd");
	$dumpvars(0,q3_tb);
	
	J = 1; K = 1; reset = 1;
	#20;
	
	J = 0; K = 0; reset = 1;
	#20;
	
	J = 1; K = 0; reset = 0;
	#20;
	
	J = 1; K = 1; reset = 0;
	#20;
	
	$finish;

end

endmodule
