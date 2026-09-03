module q3(f,a,b,c,d);
	input a,b,c,d;
	output f;
	assign f=(b|c)&(~b|d);
endmodule
