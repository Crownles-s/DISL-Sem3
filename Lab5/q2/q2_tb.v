`timescale 1ns/1ns
`include "q2.v"

module q2_tb();
reg a0, a1, a2, a3, w0, w1;
wire f;
wire f1, f2;

q2 ex1 (w0,w1,a0,a1,a2,a3,f);
initial 
begin
        $dumpfile("q2_tb.vcd");
	$dumpvars(0,q2_tb);
	
        w0=1'b0; w1=1'b0;
        a3=1'b0; a2=1'b1; a1=1'b0; a0=1'b1;
        #20;
        
        w0=1'b0; w1=1'b1;
        a3=1'b1; a2=1'b1; a1=1'b0; a0=1'b0;
        #20;
        
        w0=1'b1; w1=1'b0;
        a3=1'b0; a2=1'b1; a1=1'b0; a0=1'b0;
        #20;
        
        w0=1'b1; w1=1'b1;
        a3=1'b1; a2=1'b1; a1=1'b1; a0=1'b1;
        #20;

	$display("Test Complete");

end
endmodule
