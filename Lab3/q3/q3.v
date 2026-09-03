module q3(f,a,b,c,d);
	input a,b,c,d;
	output f;
	nor (x,a,a);
	nor (y,c,c);
	nor (p,b,d);
	nor (q,a,d);
	nor (r,y,x);
	nor (f,p,q,r);
endmodule
