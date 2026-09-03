module q1b(sum,Cout,a,b,Cin);
	input a,b,Cin;
	output sum,Cout;
	assign sum=a^b^Cin;
	assign Cout=(a&b)|(b&Cin)|(Cin&a);
endmodule
