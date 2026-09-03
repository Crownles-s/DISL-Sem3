`timescale 1ns/1ns
`include "q5.v"

module q5_tb();
reg [15:0] a;
wire [3:0]f;
wire z;

q5 ex1(f, z, a);
initial
begin

	$dumpfile("q5_tb.vcd");
	$dumpvars(0,q5_tb);
	
	a = 16'h0000;
        #20;
        
        a = 16'h0561;
        #20;
        
        a = 16'h4030;
        #20;
        
        a = 16'hDDDD;
        #20;
        
	$finish;

end
endmodule
