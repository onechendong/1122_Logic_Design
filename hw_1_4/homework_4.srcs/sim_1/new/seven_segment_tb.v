`timescale 1ns/1ns
module seven_segment_tb;
reg D, C, B, A; 
wire [6:0] result;

SevenSegment demo(D, C, B, A, result);

initial
begin
    D = 0; C = 0; B= 0; A = 0; #10;
    D = 0; C = 0; B= 0; A = 1; #10;
    D = 0; C = 0; B= 1; A = 0; #10;
    D = 0; C = 0; B= 1; A = 1; #10;
    D = 0; C = 1; B= 0; A = 0; #10;
    D = 0; C = 1; B= 0; A = 1; #10;
    D = 0; C = 1; B= 1; A = 0; #10;
    D = 0; C = 1; B= 1; A = 1; #10;
    D = 1; C = 0; B= 0; A = 0; #10;
    D = 1; C = 0; B= 0; A = 1; #10;
    $finish;
end

initial
$monitor($time, "D = %b, C = %b, B = %b, A = %b, result = %b", D, C, B, A, result);

endmodule