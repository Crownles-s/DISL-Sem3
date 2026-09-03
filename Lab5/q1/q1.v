module q1(a, b, eq, gt, lt);
    input [3:0] a, b;
    output eq, gt, lt;
    wire [3:0] i;
    
    assign i = ~(a ^ b);
    
    assign eq = i[3] & i[2] & i[1] & i[0];
    
    assign gt = (a[3] & ~b[3]) |
                (i[3] & a[2] & ~b[2]) |
                (i[3] & i[2] & a[1] & ~b[1]) | 
                (i[3] & i[2] & i[1] & a[0] & ~b[0]);
                
    assign lt = ~(gt | eq);
                
endmodule

