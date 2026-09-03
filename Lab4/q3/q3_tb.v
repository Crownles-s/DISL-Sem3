`timescale 1ns/1ns
`include "q3.v"

module q3_tb();
reg a0,a1,b0,b1;
wire p0,p1,p2,p3;

q3 ex1(p0,p1,p2,p3,a0,a1,b0,b1);
initial
begin

	$dumpfile("q3_tb.vcd");
	$dumpvars(0,q3_tb);
	
        a1 = 0; a0 = 0; b1 = 0; b0 = 0; 
        #20;
        
        a1 = 0; a0 = 1; b1 = 1; b0 = 0; 
        #20;
        
        a1 = 1; a0 = 0; b1 = 0; b0 = 1; 
        #20;
        
        a1 = 1; a0 = 1; b1 = 1; b0 = 1; 
        #20;
	
	$display("Test Complete");

end
endmodule
