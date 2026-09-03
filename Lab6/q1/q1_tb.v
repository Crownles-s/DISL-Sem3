`timescale 1ns/1ns
`include "q1.v"

module q1_tb();
reg [2:0]a;
reg En;
wire [0:7]f;

q1 ex1(f, a, En);
initial
begin

	$dumpfile("q1_tb.vcd");
	$dumpvars(0,q1_tb);
	
	a=3'b100; En=1;
	#20;
	
	a=3'b111; En=0;
	#20;
	
	a=3'b010; En=1;
	#20;
	
	a=3'b001; En=0;
	#20;
	
	$finish;

end
endmodule
