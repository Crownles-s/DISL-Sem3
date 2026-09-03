`timescale 1ns/1ns
`include "q1a.v"

module q1a_tb();
reg a,b;
wire sum, Cout;

q1a ex1(sum,Cout,a,b);
initial
begin

	$dumpfile("q1a_tb.vcd");
	$dumpvars(0,q1a_tb);
	
	a=1'b0;b=1'b0;
	#20;
	
	a=1'b0;b=1'b1;
	#20;
	
	a=1'b1;b=1'b0;
	#20;
	
	a=1'b1;b=1'b1;
	#20;
	
	$display("Test Complete");

end
endmodule
