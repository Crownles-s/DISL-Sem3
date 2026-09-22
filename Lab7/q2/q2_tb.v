`timescale 1ns/1ns
`include "q2.v"

module q2_tb();
reg T, clk, reset;
wire Q;

q2 ex1(T, Q, reset, clk);

initial begin
	clk = 0;
	forever #20 clk = ~clk;
end

initial begin
	
	$dumpfile("q2_tb.vcd");
	$dumpvars(0,q2_tb);
	
	reset = 0; T = 0;
    	#40;
    	
        reset = 1; T = 0;
    	#40;
    	
 	T = 1;
    	#80;
    	
    	T = 0;
    	#40;
    	
    $finish;
end

endmodule
