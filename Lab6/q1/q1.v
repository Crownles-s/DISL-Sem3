module dec2to4(f, a, En);
    input [1:0] a;
    input En;
    output reg [0:3]f;
    
    always @(*)
    	if (En==1'b0) f=4'b0000;
    	else if (a==2'b00) f=4'b1000;
    	else if (a==2'b01) f=4'b0100;
    	else if (a==2'b10) f=4'b0010;
        else if (a==2'b11) f=4'b0001;
endmodule

module q1(f, a, En);
    input [2:0] a;
    input En;
    output [0:7] f;
    
    wire En_lower;
    wire En_upper;

    assign En_lower = En & (~a[2]); 
    assign En_upper = En & a[2];

    dec2to4 lower (f[0:3], a[1:0], En_lower);
    dec2to4 upper (f[4:7], a[1:0], En_upper);
        
endmodule

