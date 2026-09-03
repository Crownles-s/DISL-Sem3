module dec3to8(f, a, En);
    input [2:0] a;
    input En;
    output reg [0:7] f;
    
    integer k;
    
    always @(*) 
    begin
        for (k = 0; k <= 7; k = k+1) 
        begin
            if ((a == k) && (En == 1'b1))
                f[k] = 1'b1;
            else
                f[k] = 1'b0;
        end
    end
    
endmodule

module q2 (f, a, En);
    input [3:0] a;
    input En;
    output [0:15] f;

    wire En_lower, En_upper;

    assign En_lower = En & (~a[3]);
    assign En_upper = En & a[3];

    dec3to8 lower (f[0:7], a[2:0], En_lower);
    dec3to8 upper (f[8:15], a[2:0], En_upper);

endmodule

