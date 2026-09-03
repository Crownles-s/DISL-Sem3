module q4(f,a,b,c,d);
	input a,b,c,d;
	output f;
	assign f=(~a|b|~c)&(a|~b|~c)&(~b|c|d)&(~a|c|~d);
endmodule
