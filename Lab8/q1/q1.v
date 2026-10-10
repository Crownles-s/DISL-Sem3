module q1(w, a, clk, reset);
     input w, clk, reset;
     output reg [5:0]a;
     
     integer k;
     
     always@(posedge clk) begin
     
     	if(reset) 
     	   a <= 6'b000000;
     	
     	else begin
     	   for (k = 0; k < 5; k = k+1)
     		a[k] <= a[k+1];
           a[5] <= w;
        end
     end
endmodule


