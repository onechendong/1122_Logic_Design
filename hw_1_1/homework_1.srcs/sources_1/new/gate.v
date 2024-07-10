module logic_gates(input A, B, C, D, E ,F, G, output Z);
wire w1, w2, w3, w4, w5, w6, w7;

or (w1, A, B); //w1 = A or B
not (w2, w1); //w2 = ~w1
and (w3, C, D); //w3 = C and D
and (w4, w2, w3); //w4 = w2 and w3
not (w5, E); //w5 = ~E
or (w6, w5, F); //w6 = w5 or F
and (w7, w6, G); //w7 = w6 and G
or (Z, w4, w7); //Z = w4 or w7
                   
endmodule