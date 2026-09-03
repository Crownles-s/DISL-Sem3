module q1a(sum,Cout,a,b);
	input a,b;
	output sum, Cout;
	assign sum=a^b;
	assign Cout=a&b;  
endmodule
