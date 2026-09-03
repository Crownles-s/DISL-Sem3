module q1(f,a,b,c,d);
	input a,b,c,d;
	output f;
	and (k,a,b);
	or (l,k,c); //assign l=(a&b)|c;
	not (m,l); 
	and (n,m,d); //assign n=(~l&d);
	or (o,d,l); //assign o=d|l;
	and (f,o,n); //assign f=o|n
endmodule
