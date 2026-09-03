module q4(f, z, a);
    input [3:0] a;
    output reg [1:0]f;
    output reg z;


    always @(*) begin
        f = 2'b00;
        z = 1'b1;
        
        casex (a)
            4'b1xxx: f = 2'b11;
            4'b01xx: f = 2'b10;
            4'b001x: f = 2'b01;
            4'b0001: f = 2'b00;
            
            4'b0000: 
            begin
                f = 2'b00;
                z = 1'b0;
            end
            
            default: 
            begin
                f = 2'bxx;
                z = 1'b0;
            end
        endcase
    end

endmodule

