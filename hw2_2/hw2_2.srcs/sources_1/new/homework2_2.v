module hw2_2(inputA, inputB, R01, R02, R91, R92, QA, QB, QC, QD);
input inputA, inputB, R01, R02, R91, R92;
output QA, QB, QC, QD;
    wire w1, w2;
    assign w1 = ~(R91 & R92);
    assign w2 = ~(R01 & R02);
    JKFF J1(1'b1, 1'b1, inputA, ~w1, ~w2, QA);
    JKFF J2(~QD, 1'b1, inputB, 1'b0, (~w1)|(~w2), QB);
    JKFF J3(1'b1, 1'b1, QB, 1'b0, (~w1)|(~w2), QC);
    JKFF J4(QC&QB, QD, inputB, ~w1, ~w2, QD);
endmodule

module JKFF(input J, K, clk, preset, clear, output reg Q);
    always@(*)
    begin
        if(preset && clear)
            Q = Q;  //when both of preset and clear =1, Q=Q
        else if(preset)
            Q = 1;   //when preset=1, Q=1
        else if(clear)
            Q = 0;  //when clear=1, Q=0
        else
            ; 
    end
    
    always@(negedge clk or posedge preset or posedge clear)
    begin
        Q <= (J&(~Q))+((~K)&Q);            
        /*case({J,K})
            2'b00: Q<=Q;
            2'b01: Q<=0;
            2'b10: Q<=1;
            2'b11: Q<=~Q;
        endcase*/
    end
    
endmodule