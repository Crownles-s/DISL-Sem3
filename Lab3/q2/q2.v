module q2(f,a,b,c,d);
	input a,b,c,d;
	output f;
	nor (w,a,a);
	nor (x,b,b);
	nor (y,c,c);
	nor (z,d,d);
	nor (p,y,z);
	nor (q,x,d);
	nor (r,w,x);
	nor (f,p,q,r);
endmodule
