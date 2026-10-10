`timescale 1ns/1ns
`include "q1.v"

module q1_tb();
reg w, clk, reset;
wire [5:0]a;

q1 ex1(w, a, clk, reset);

initial begin
	clk = 0;
	forever #10 clk = ~clk;
end

initial begin
	
	$dumpfile("q1_tb.vcd");
	$dumpvars(0,q1_tb);
	
	reset = 1; #20;
	
	reset = 0;
	w = 1; #20;
	
	w = 0; #20;
	
	w = 1; #20;
	
	w = 1; #20;
	
	w = 0; #20;
	
	w = 1; #20;
	
	$finish;

end

endmodule
