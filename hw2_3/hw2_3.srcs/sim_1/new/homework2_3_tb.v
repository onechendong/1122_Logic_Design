module hw2_3_tb;
reg  clk = 0;
reg  reset = 0;
reg  coin = 0;
reg  button = 0;
wire candy;
wire[1:0] state;

hw2_3 test (
    .clk(clk),
    .reset(reset),
    .coin(coin),
    .button(button),
    .candy(candy),
    .state(state)
);

always #5 clk = ~clk;

initial 
begin
    reset = 1; coin = 0; button = 0; 
    #10;
    reset = 0; 
    #40;
    coin = 1; #12;
    coin = 0;
    #45;
    button = 1; #12;
    button = 0; 
    #20;
    coin = 0;
    #40;
    button = 1; #12; 
    #30;
    button = 0; #12
    #20;
    coin = 1; #12;
    coin = 0;
    #45;
    button = 1; #12;
    button = 0;
    #20;
    
    $finish;
end

endmodule
