`timescale 1ns/1ns
`include "q2.v"

module q2_tb();
reg clk, x, resetn;
wire A, B;

q2 ex1(clk, x, A, B, resetn);

initial begin
	clk = 0;
	forever #10 clk = ~clk;
end

initial begin
	
	$dumpfile("q2_tb.vcd");
	$dumpvars(0,q2_tb);
	
	resetn = 0; x = 0; #10;
    
    	resetn = 1; 
    	x = 1; #90;
    	x = 0; #90;

	$finish;

end
endmodule
