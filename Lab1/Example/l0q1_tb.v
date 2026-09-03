`timescale 1ns/1ns
`include "l0q1.v"

module l0q1_tb();
reg a,b,c;
wire f;

l0q1 ex1(f,a,b,c);
initial
begin

	$dumpfile("l0q1_tb.vcd");
	$dumpvars(0,l0q1_tb);
	
	a=1'b0;b=1'b0;c=1'b0;
	#20;
	
	a=1'b0;b=1'b0;c=1'b1;
	#20;
	
	a=1'b0;b=1'b1;c=1'b0;
	#20;
	
	a=1'b0;b=1'b1;c=1'b1;
	#20;
	
	a=1'b1;b=1'b0;c=1'b0;
	#20;
	
	a=1'b1;b=1'b0;c=1'b1;
	#20;
	
	a=1'b1; b=1'b1; c=1'b0;
	#20;
	
	a=1'b1;b=1'b1;c=1'b1;
	#20;
	
	$display("Test Complete");

end
endmodule
