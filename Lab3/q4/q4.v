module q4(f,a,b,c,d);
	input a,b,c,d;
	output f;
	nand (x,a,a);
	nand (y,b,b);
	nand (z,d,d);
	nand (p,x,y);
	nand (q,c,d);
	nand (r,z,y);
	nand (f,p,q,r);
endmodule
