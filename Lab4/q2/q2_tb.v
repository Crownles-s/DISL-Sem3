`timescale 1ns/1ns
`include "q2.v"

module q2_tb();
reg M;
reg a3, a2, a1, a0, b3, b2, b1, b0;
wire r3, r2, r1, r0, Cout;

q2 ex1 (r0, r1, r2, r3, Cout, a0, a1, a2, a3, b0, b1, b2, b3, M);
initial 
begin
        $dumpfile("q2_tb.vcd");
	$dumpvars(0,q2_tb);
	
        M=1'b0;
        a3=1'b0; a2=1'b1; a1=1'b0; a0=1'b1; // 5
        b3=1'b0; b2=1'b0; b1=1'b1; b0=1'b1; // 3
        #20;

	M=1'b0;
        a3=1'b0; a2=1'b1; a1=1'b1; a0=1'b0; // 6
        b3=1'b0; b2=1'b1; b1=1'b0; b0=1'b1; // 5
        #20;
        
        M=1'b1;
        a3=1'b0; a2=1'b1; a1=1'b1; a0=1'b1; // 7
        b3=1'b0; b2=1'b0; b1=1'b1; b0=1'b1; // 3
        #20;
        
	M=1'b1;
        a3=1'b0; a2=1'b1; a1=1'b0; a0=1'b0; // 4
        b3=1'b0; b2=1'b1; b1=1'b1; b0=1'b0; // 6
        #20;
        
	$display("Test Complete");

end
endmodule
