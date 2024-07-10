`timescale 1ns/1ns
module truth_table_tb;
reg A, B, C; 
wire X, Y;

truth_table demo(A, B, C, X, Y);
 
initial
begin
    A=1'b0; B=1'b0; C=1'b0; #10;
    A=1'b0; B=1'b0; C=1'b1; #10;
    A=1'b0; B=1'b1; C=1'b0; #10;
    A=1'b0; B=1'b1; C=1'b1; #10;
    A=1'b1; B=1'b1; C=1'b0; #10;
    A=1'b1; B=1'b1; C=1'b1; #10;
    A=1'b1; B=1'b0; C=1'b0; #10;
    A=1'b1; B=1'b0; C=1'b1; #10;
    $finish;
end

initial
$monitor($time, "A = %b, B = %b, C = %b, X = %b, Y = %b", A, B, C, X, Y);

endmodule