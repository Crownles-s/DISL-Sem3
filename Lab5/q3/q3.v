module mux4(w, a, f);
	input [3:0]a;
	input [1:0]w;
	output reg f;
	
	always@(*)
	  f= (w == 2'b00) ? a[0] : (w == 2'b01) ? a[1] : (w == 2'b10) ? a[2] : a[3]; 

endmodule

module q3(w, a, f);
	input [15:0]a;
	input [3:0]w;
	output f;
	
	wire [3:0]t;	
	
	mux4 stage1(w[1:0], a[3:0], t[0]);
	mux4 stage2(w[1:0], a[7:4], t[1]);
	mux4 stage3(w[1:0], a[11:8], t[2]);
	mux4 stage4(w[1:0], a[15:12], t[3]);
	mux4 final(w[3:2], t[3:0], f);
	
endmodule
