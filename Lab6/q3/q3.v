module dec2to4(f, a, En);
    input [1:0] a;
    input En;
    output reg [0:3]f;
    
    always @(*)
    begin
    
    	case(a)
    	    2'b00: f=4'b1000;
    	    2'b01: f=4'b0100;
    	    2'b10: f=4'b0010;
            2'b11: f=4'b0001;
    	endcase
    	
    	if (En==1'b0) f=4'b0000;
    end	
     	
endmodule

module q3(f, a, En);
    input [3:0] a;
    input En;
    output [0:15] f;

    wire [0:3] sub_en;

    dec2to4 start (sub_en, a[3:2], En);

    dec2to4 block0 (f[0:3],   a[1:0], sub_en[0]);
    dec2to4 block1 (f[4:7],   a[1:0], sub_en[1]);
    dec2to4 block2 (f[8:11],  a[1:0], sub_en[2]);
    dec2to4 block3 (f[12:15], a[1:0], sub_en[3]);

endmodule
