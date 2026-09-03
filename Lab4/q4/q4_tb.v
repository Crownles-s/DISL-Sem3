`timescale 1ns/1ns
`include "q4.v"

module q4_tb();
reg [3:0]a,b;
reg Cin;
wire [3:0]sum;
wire Cout;

q4 ex1(sum,Cout,a,b,Cin);
initial
begin

	$dumpfile("q4_tb.vcd");
	$dumpvars(0,q4_tb);
	
	a=4'b0101;b=4'b0011;Cin=1'b0;
	#20;
	
	a=4'b0110;b=4'b0101;Cin=1'b0;
	#20;
	
	a=4'b0111;b=4'b0011;Cin=1'b0;
	#20;
	
	a=4'b1001;b=4'b0000;Cin=1'b1;
	#20;
	
	$display("Test Complete");

end
endmodule
