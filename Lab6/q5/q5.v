module q5(f, z, a);
    output reg [3:0] f;
    output reg z;
    input  wire [15:0] a;

    integer i;

    always @(*) begin
        f = 4'b0000;
        z = 1'b0;

        for (i = 0; i < 16; i = i + 1) 
        begin
            if (a[i] == 1'b1) 
            begin
                f = i[3:0];
                z = 1'b1;
            end
        end
    end

endmodule

