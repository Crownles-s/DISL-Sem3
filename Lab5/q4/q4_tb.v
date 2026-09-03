`timescale 1ns/1ns
`include "q4.v"

module q4_tb();
reg [15:0]a;
reg [3:0]w;
wire f;

q4 ex1(w, a, f);
initial
begin

	$dumpfile("q4_tb.vcd");
	$dumpvars(0,q4_tb);
	
	a = 16'h0301; w = 4'b0100;
        #20;
        
        a = 16'h4080; w = 4'b0111;
        #20;
        
        a = 16'h0150; w = 4'b1010;
        #20;
        
        a = 16'h8000; w = 4'b1111;
        #20;
        
	$display("Test Complete");

end
endmodule
