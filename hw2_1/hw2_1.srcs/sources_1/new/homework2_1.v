module hw2_1 (
    input [2:0] R,
    input L,
    input clk,
    output [2:0] Qout // Q
    );
    wire w1 = Qout[2]^Qout[1];
    MUX_and_DFF M1(L, Qout[2], R[0], clk, Qout[0]);
    MUX_and_DFF M2(L, Qout[0], R[1], clk, Qout[1]);
    MUX_and_DFF M3(L, w1, R[2], clk, Qout[2]);
endmodule


module MUX_and_DFF(input L, I0, I1, clk, output reg Q);
    wire D;
    assign D = L ? I1 : I0; //MUX
    initial Q = 0;
    always@(posedge clk)    //D flip-flop
    begin
        Q = D;
    end
endmodule




