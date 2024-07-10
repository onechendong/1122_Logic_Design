`timescale 1ns/1ns
module dodge_game_tb;

reg [1:0] btn;
reg clk;
wire [13:0] ar;
wire [2:0] led;      // LED ��ܥͩR�ƶq

dodge_game uut (
    .btn(btn),
    .clk(clk),
    .ar(ar),
    .led(led)
);

// ���� clk
initial begin
    clk = 0;    
    forever #10 clk = ~clk;  // �C 10 �Ӯɶ����½��@���A���� 50MHz �������H��
end

// star testing
initial begin
    // ��l�� btn
    btn = 2'b00;

    // �L�X��l�� led
    $display("Initial state: LED = %b", led);

    // ����� btn0(right) �P btn1(left)
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