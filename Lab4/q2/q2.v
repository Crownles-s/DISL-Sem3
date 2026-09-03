module fulladd(sum,Cout,a,b,Cin);
	input a,b,Cin;
	output sum,Cout;
	assign sum=a^b^Cin;
	assign Cout=(a&b)|(b&Cin)|(Cin&a);
endmodule

module fouradder(s0, s1, s2, s3, Cout, a0, a1, a2, a3, b0, b1, b2, b3, Cin);
	output s0, s1, s2, s3, Cout;
	input a0, a1, a2, a3, b0, b1, b2, b3, Cin;
	
	fulladd w(s0,c0,a0,b0,Cin);
	fulladd x(s1,c1,a1,b1,c0);
	fulladd y(s2,c2,a2,b2,c1);
	fulladd z(s3,Cout,a3,b3,c2);
	
endmodule

module q2(r0, r1, r2, r3, Cout, a0, a1, a2, a3, b0, b1, b2, b3, M);
	input M, a3, a2, a1, a0, b3, b2, b1, b0; //0=Add, 1=Subtract     
	output r3, r2, r1, r0, Cout;              
	
	assign y0 = b0 ^ M;
	assign y1 = b1 ^ M;
	assign y2 = b2 ^ M;
	assign y3 = b3 ^ M;
	
	fouradder x1(r0, r1, r2, r3, Cout, a0, a1, a2, a3, y0, y1, y2, y3, M);
endmodule
	
