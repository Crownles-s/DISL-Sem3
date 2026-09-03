module halfadd(sum,Cout,a,b);
	input a,b;
	output sum, Cout;
	assign sum=a^b;
	assign Cout=a&b;  
endmodule

module q3(p0,p1,p2,p3,a0,a1,b0,b1);
	input a0,a1,b0,b1;
	output p0,p1,p2,p3;
	assign k1=a1^b0;
	assign k2=a0^b1;
	assign k3=a1^b1;
	assign p0=a0^b0;
	halfadd x(p1, Cout, k1, k2);
	halfadd y(p2, p3, k3, Cout);
endmodule
