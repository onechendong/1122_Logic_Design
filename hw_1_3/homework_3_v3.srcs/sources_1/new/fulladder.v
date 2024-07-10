module fulladder(input A, B, Cin, output S, Cout);
wire w1, w2, w3;
xor (S, A, B, Cin); //S = A^B^Cin
and (w1, A, B); //w1 = A and B
and (w2, A, Cin); //w2 = A and Cin
and (w3, B, Cin); //w3 = B and Cin
or (Cout, w1, w2, w3); //Cout = AB or BCin or ACin
endmodule


module AddFourBits (input [3:0] num1, num2, input Cin, output [4:0] sum);
wire [3:0] carry;
fulladder F0(num1[0], num2[0], Cin, sum[0], carry[0]);
fulladder F1(num1[1], num2[1], carry[0], sum[1], carry[1]);
fulladder F2(num1[2], num2[2], carry[1], sum[2], carry[2]);
fulladder F3(num1[3], num2[3], carry[2], sum[3], carry[3]);
or (sum[4], carry[3], 0); //assign sum[4] = carry[3];
endmodule 


module ToExcess3(input [3:0] sum, output [3:0] excess3);
AddFourBits A0(sum, 4'b0011, 0, excess3);
endmodule

module top(input[3:0] A, B, input Cin, output[3:0] excess3, output Cout);
wire [4:0] sum;
AddFourBits Add(A, B, Cin, sum);
ToExcess3 To(sum[3:0], excess3);
or (Cout, sum[4], 0); //assign Cout = sum[4];
endmodule