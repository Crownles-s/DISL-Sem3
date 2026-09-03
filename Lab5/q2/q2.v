module mux2(w0,a0,a1,f);
	input a0, a1, w0; 
	output reg f;
	always @(*)
	  if (w0==0)
	    f=a0;
	  else 
	    f=a1;
endmodule

module q2(w0,w1,a0,a1,a2,a3,f);
	input a0, a1, a2, a3, w0, w1; 
	output f;
	wire f1, f2;
	mux2 stage1(w0,a0,a1,f1);
	mux2 stage2(w0,a2,a3,f2);
	mux2 stage3(w1,f1,f2,f);
endmodule
