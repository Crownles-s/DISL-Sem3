`timescale 1ns/1ns
`include "q2.v"

module q2_tb();
reg [3:0] a;
reg En;
wire [0:15] f;

q2 ex3 (f, a, En);

initial 
begin
	$dumpfile("q2_tb.vcd");
        $dumpvars(0, q2_tb);
        
        En = 0; a = 4'b0011; 
        #20;
        
        En = 1; a = 4'b0101; 
        #20;
        
        En = 0; a = 4'b1100; 
        #20;
      
        En = 1; a = 4'b1110; 
        #20;

        $finish;
        
end
endmodule
