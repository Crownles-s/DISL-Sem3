module l0q1(f,a,b,c);
	input a,b,c;
	output f;
	and (m,a,b);
	not (k,b);
	and (n,k,c);
	or (f,m,n);
endmodule
