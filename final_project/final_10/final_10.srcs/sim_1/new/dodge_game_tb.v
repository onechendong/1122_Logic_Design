`timescale 1ns/1ns
module dodge_game_tb;

reg [1:0] btn;
reg clk;
wire [13:0] ar;
wire [2:0] led;      // LED 顯示生命數量

dodge_game uut (
    .btn(btn),
    .clk(clk),
    .ar(ar),
    .led(led)
);

// 產生 clk
initial begin
    clk = 0;    
    forever #10 clk = ~clk;  // 每 10 個時間單位翻轉一次，產生 50MHz 的時鐘信號
end

// star testing
initial begin
    // 初始化 btn
    btn = 2'b00;

    // 印出初始化 led
    $display("Initial state: LED = %b", led);

    // 交錯按 btn0(right) 與 btn1(left)
    #100;
    btn[0] = 1;
    $display("LED = %b", led);
    #20;   
    btn[0] = 0;
    $display("LED = %b", led);
    #30;
    btn[1] = 1;
    $display("LED = %b", led);
    #20;   
    btn[1] = 0;
    $display("LED = %b", led);
    #50;
    btn[0] = 1;
    $display("LED = %b", led);
    #20;   
    btn[0] = 0;
    $display("LED = %b", led);
    #40;
    btn[1] = 1;
    $display("LED = %b", led);
    #20;   
    btn[1] = 0;
    $display("LED = %b", led);
    #30;
    btn[0] = 1;
    $display("LED = %b", led);
    #20;   
    btn[0] = 0;
    $display("LED = %b", led);
    
    #100;  
    btn[1] = 1;
    $display("LED = %b", led);
    #20;   
    btn[1] = 0;
    $display("LED = %b", led);
    #70;  
    btn[0] = 1;
    $display("LED = %b", led);
    #20;   
    btn[0] = 0;
    $display("LED = %b", led);
    #50;  
    btn[1] = 1;
    $display("LED = %b", led);
    #20;   
    btn[1] = 0;
    $display("LED = %b", led);
    #80;
    btn[0] = 1;
    $display("LED = %b", led);
    #20;   
    btn[0] = 0;
    $display("LED = %b", led);

    #500;
    $display("Final state: LED = %b", led);

    $finish;
end

endmodule