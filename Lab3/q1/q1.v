module q1(f,a,b,c,d);
	input a,b,c,d;
	output f;
	nand (x,a,a);
	nand (y,c,c);
	nand (p,x,y);
	nand (q,x,d);
	nand (r,b,y);
	nand (s,b,d);
	nand (f,p,q,r,s);
endmodule
