`timescale 1ns/1ns
`include "q3.v"

module q3_tb();
reg [15:0]a;
reg [3:0]w;
wire f;

q3 ex1(w, a, f);
initial
begin

	$dumpfile("q3_tb.vcd");
	$dumpvars(0,q3_tb);
	
	w = 4'b0000;
        a = 16'b0000_0000_0000_0001; 
        #20;
        
        w = 4'b0000; 
        a = 16'b0000_0000_0000_0001; 
        #20;
        
        w = 4'b0101; 
        a = 16'b0000_0000_0010_0000; 
        #20;
        
        w = 4'b1010; 
        a = 16'b0101_0101_0101_0101; 
        #20;
        
        w = 4'b1111; 
        a = 16'b1000_0000_0000_0000; 
        #20;
        
	$display("Test Complete");

end
endmodule
