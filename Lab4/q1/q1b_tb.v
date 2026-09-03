`timescale 1ns/1ns
`include "q1b.v"

module q1b_tb();
reg a,b,Cin;
wire sum,Cout;

q1b ex1(sum,Cout,a,b,Cin);
initial
begin

	$dumpfile("q1b_tb.vcd");
	$dumpvars(0,q1b_tb);
	
	a=1'b0;b=1'b0;Cin=1'b0;
	#20;
	
	a=1'b0;b=1'b0;Cin=1'b1;
	#20;
	
	a=1'b0;b=1'b1;Cin=1'b0;
	#20;
	
	a=1'b0;b=1'b1;Cin=1'b1;
	#20;
	
	a=1'b1;b=1'b0;Cin=1'b0;
	#20;
	
	a=1'b1;b=1'b0;Cin=1'b1;
	#20;
	
	a=1'b1;b=1'b1;Cin=1'b0;
	#20;
	
	a=1'b1;b=1'b1;Cin=1'b1;
	#20;
	
	$display("Test Complete");

end
endmodule
