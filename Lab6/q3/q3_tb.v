`timescale 1ns/1ns
`include "q3.v"

module q3_tb();
reg [3:0] a;
reg En;
wire [0:15] f;

q3 ex3 (f, a, En);

initial 
begin
	$dumpfile("q3_tb.vcd");
        $dumpvars(0, q3_tb);
        
        En = 1; a = 4'b1101; 
        #20;
        
        En = 1; a = 4'b0101; 
        #20;
        
        En = 1; a = 4'b1001; 
        #20;
      
        En = 0; a = 4'b1111; 
        #20;

        $finish;
end
endmodule
