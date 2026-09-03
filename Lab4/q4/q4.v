module fulladd(sum,Cout,a,b,Cin);
	input a,b,Cin;
	output sum,Cout;
	assign sum=a^b^Cin;
	assign Cout=(a&b)|(b&Cin)|(Cin&a);
endmodule

module fouradder(s, Cout, a, b, Cin);
	output [3:0]s;
	output Cout;
	input [3:0]a, b; 
	input Cin;
	wire [3:0]c;
	
	fulladd w(s[0],c[0],a[0],b[0],Cin);
	fulladd x(s[1],c[1],a[1],b[1],c[0]);
	fulladd y(s[2],c[2],a[2],b[2],c[1]);
	fulladd z(s[3],Cout,a[3],b[3],c[2]);
	
endmodule

module q4 (sum, Cout, a,b,Cin);
	input [3:0]a,b;
	input Cin;
	output [3:0]sum;
	output Cout;
	
	wire c1,correction;
	wire [3:0]s;
	
	fouradder f1 (s,c1,a,b,Cin);
	assign correction=c1|(s[3]&s[2])|(s[3]&s[1]);
	fouradder f2 (sum, Cout, s, correction ? 4'b0110:4'b0000,1'b0);
endmodule
