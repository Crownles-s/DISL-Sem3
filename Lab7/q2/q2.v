module q2(T, Q, reset, clk);
    input T, reset, clk;
    output reg Q;
    
    always@(negedge clk or negedge reset)
    if (!reset)
    	Q <= 0;
    else if (T)
    	Q <= ~Q;
    else
    	Q <= Q;
        
endmodule

