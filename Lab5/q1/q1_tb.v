`timescale 1ns/1ns
`include "q1.v"

module q1_tb();
reg [3:0]a,b;
wire eq, gt, lt;
wire [3:0]i;

q1 ex1(a, b, eq, gt, lt);
initial
begin

	$dumpfile("q1_tb.vcd");
	$dumpvars(0,q1_tb);
	
	a=4'b1001;b=4'b1001;
	#20;
	
	a=4'b1101;b=4'b1001;
	#20;
	
	a=4'b1001;b=4'b1111;
	#20;
	
	a=4'b1001;b=4'b0000;
	#20;
	
	$display("Test Complete");

end
endmodule
