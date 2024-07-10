module truth_table(input A, B, C, output X, Y);

wire w1, w2, w3, w4, w5;
//X
not (w1, A); //w1 = ~A
not (w2, C); //w2 = ~C
and (w3, w1, B); //w3 = ~A and B
and (w4, w1, w2); //w4 = ~A and ~C 
and (w5, B, w2); //w5 = B and ~C
or (X, w3, w4, w5); //w5 = ~AB or ~A~C or B~C

wire w6, w7, w8, w9, w10, w11, w12;
//Y
not (w6, A); //w6 = ~A
not (w7, B); //w7 = ~B
not (w8, C); //w8 = ~C
and (w9, w6, w7, C); //w9 = ~A~BC
and (w10, w6, B, w8); //w10 = ~AB~C
and (w11, A, B, C); //w11 = ABC
and (w12, A, w7, w8); //w12 = A~B~C
or (Y, w9, w10, w11, w12); //Y = ~A~BC or ~AB~C or ABC or A~B~C


endmodule
