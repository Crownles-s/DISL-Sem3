module q2 #(parameter N = 8)(
    input wire clk,
    input wire reset,
    input wire [N-1:0] w,
    output reg [N-1:0] a
);

    always @(posedge clk) begin
        if (reset)
            a <= {N{1'b0}}; 
            
        else begin
            a <= w;
        end
    end

endmodule
