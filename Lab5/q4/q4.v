module mux2(w0,a0,a1,f);
	input a0, a1, w0; 
	output reg f;
	always @(*)
	  if (w0==0)
	    f=a0;
	  else 
	    f=a1;
endmodule

module mux8(w, a, f);
	output reg f;
	input [7:0]a;
	input [2:0]w;
	always @(*)
	case(w)
	    3'b000: f = a[0];
            3'b001: f = a[1];
            3'b010: f = a[2];
            3'b011: f = a[3];
            3'b100: f = a[4];
            3'b101: f = a[5];
            3'b110: f = a[6];
            3'b111: f = a[7];
	endcase
	
endmodule

module q4 (w, a, f);
	input [15:0]a;
	input [3:0]w;
	output f;
	
	wire [1:0]t;
	
	mux8 stage1(w[2:0], a[7:0], t[0]);
	mux8 stage2(w[2:0], a[15:8], t[1]);
	mux2 final(w[3], t[0], t[1], f);
	
endmodule
