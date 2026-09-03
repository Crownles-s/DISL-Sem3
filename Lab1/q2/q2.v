module q2(f, g, a, b, c, d);
	input a,b,c,d;
	output f,g;
	nand(n,a,b);
	xor(f,d,n,c);
	nor(g,b,c,d);
endmodule
