`timescale 1ns/1ns
`include "q4.v"

module q4_tb();
reg [3:0] a;
wire [1:0]f;
wire z;

q4 ex1(f, z, a);
initial
begin

	$dumpfile("q4_tb.vcd");
	$dumpvars(0,q4_tb);
	
	a = 4'b0000;
        #20;
        
        a = 4'bxx10;
        #20;
        
        a = 4'b1000;
        #20;
        
        a = 4'bxxx1;
        #20;
        
	$finish;

end
endmodule
