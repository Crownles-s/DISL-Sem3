module q1(f,a,b,c,d);
	input a,b,c,d;
	output f;
	assign f=(~a&b)|(~b&c)|(c&d)|(b&c&d);
endmodule
