module q2(f,a,b,c,d);
	input a,b,c,d;
	output f;
	assign f=(~b&d)|(b&~c&~d)|(~b&c);
endmodule
