module q3(a, clk, reset);
     input clk, reset;
     output reg [4:0]a;
     
     integer k;
     
     always@(posedge clk) begin
     
     	if(reset) 
     	   a <= 5'b10000;
     	
     	else begin
     	   for (k = 0; k < 4; k = k+1)
     		a[k] <= a[k+1];
           a[4] <= ~a[0];
        end
     end
endmodule


