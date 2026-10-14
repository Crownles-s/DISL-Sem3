`timescale 1ns/1ns
`include "q1.v"

module q1_tb();
reg clk, E, x, resetn;
wire A, B;

q1 ex1(clk, E, x, A, B, resetn);

initial begin
	clk = 0;
	forever #10 clk = ~clk;
end

initial begin
	
	$dumpfile("q1_tb.vcd");
	$dumpvars(0,q1_tb);
	
	resetn = 0; E = 0; x = 0; #20;
    	resetn = 1; E = 1; x = 1; #30;
    	E = 0; x = 1; #30;
    	resetn = 0; #10;
    	resetn = 1; E = 1; x = 0; #30;	
	
	$finish;

end
endmodule
