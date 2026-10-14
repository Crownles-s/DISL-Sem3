module q2(clk, x, A, B, resetn);
    input clk, x, resetn;
    output reg A, B;
    
    wire TA, TB;
    assign TA = (B&~x)|(~A&B);
    assign TB = (~B&~x)|(A&~x)|(~A&B&x);
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            A <= 1'b0;
            B <= 1'b0;
        end else begin
            if (TA) A <= ~A; 
            if (TB) B <= ~B;
        end
    end
endmodule

