`timescale 1ns/1ns
`include "q2.v"

module q2_tb();
    reg [7:0] w;
    reg clk, reset;
    wire [7:0] a;

    q2 #(.N(8)) ex1 (
        .w(w), 
        .a(a), 
        .clk(clk), 
        .reset(reset)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        $dumpfile("q2_tb.vcd");
        $dumpvars(0, q2_tb);
        
        reset = 1; #20;
        
        reset = 0;
        w = 8'h01; #20;
        
        w = 8'h0F; #20;
        
        w = 8'hAA; #20;
        
        w = 8'hFF; #20;
        
        reset = 1; #20;
        
        $finish;
    end

endmodule
