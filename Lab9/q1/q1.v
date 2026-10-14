module q1(clk, E, x, A, B, resetn);
    input clk, E, x, resetn;
    output reg A, B;
    
    wire JA, KA, JB, KB;
    assign JA = E & ~(B ^ x);
    assign KA = E & ~(B ^ x);
    assign JB = E;
    assign KB = E;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            A <= 1'b0;
            B <= 1'b0;
        end else begin
            case ({JA, KA})
                2'b00: A <= A;
                2'b01: A <= 1'b0;
                2'b10: A <= 1'b1;
                2'b11: A <= ~A;
            endcase

            case ({JB, KB})
                2'b00: B <= B;
                2'b01: B <= 1'b0;
                2'b10: B <= 1'b1;
                2'b11: B <= ~B;
            endcase
        end
    end

endmodule

