module q1(D, Q, reset, clk);
    input D, reset, clk;
    output reg Q;
    
    always@(posedge clk or posedge reset)
    if (reset)
    	Q <= 1'b0;
    else
    	Q <= D;
        
endmodule

