module SevenSegment(input D, C, B, A, output [6:0] result);
//result[0]=g, result[1]=f ... result[6]=a
wire w1, w2, w3, w4;
not (w1, A);    //w1=~A
not (w2, B);    //w2=~B
not (w3, C);    //w3=~C
not (w4, D);    //w4=~D
//a
wire a1, a2;
and (a1, C, w1);
and (a2, w4, w3, w2, A);
or (result[6], a1, a2);
//b
wire b1, b2;
and (b1, C, w2, A); 
and (b2, C, B, w1);
or (result[5], b1, b2);
//c
and (result[4], w3, B, w1);
//d
wire d1, d2, d3, d4;
and (d1, C, w2, w1);
and (d2, C, B, A);
and (d3, w4, w3, w2, A);
and (d4, D, A);
or (result[3], d1, d2, d3, d4);
//e
wire e1;
and (e1, C, w2);
or (result[2], e1, A);
//f
wire f1, f2, f3;
and (f1, B, A);
and (f2, w3, B, w1);
and (f3, w4, w3, w2, A);
or (result[1], f1, f2, f3);
//g
wire g1, g2;
and (g1, w4, w3, w2);
and (g2, C, B, A);
or (result[0], g1, g2);
endmodule