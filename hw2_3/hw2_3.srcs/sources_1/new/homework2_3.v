module hw2_3 (
    input clk,
    input reset,
    input coin,
    input button,
    output reg[1:0] state,
    output reg candy);
    
    reg [1:0] current_state, next_state;

    parameter S0 = 2'b00;   //IDLE
    parameter S1 = 2'b01;   //COIN_INSERT
    parameter S2 = 2'b10;   //CANDY_DISPENSED
    
    always@(posedge clk or posedge reset)
    begin
        if (reset)  state <= S0;
        else        state <= next_state;
    end
    
    always@(*)
    begin
        //next_state = state;
        case(state)
            S0: candy = 1'b0;
            S1: candy = 1'b0;
            S2: candy = 1'b1;
        endcase
    end
    
    always@(*)
    begin
        case(state)
            S0: if(coin & button)   next_state = S2;    //button=1, coin=1
                else if(coin)       next_state = S1;    //coin=1
            S1: if(button)  next_state = S2;    //button=1
            S2: if(coin)    next_state = S1;    //coin=1
                else        next_state = S0;
            default next_state = S0;
        endcase
    end

endmodule