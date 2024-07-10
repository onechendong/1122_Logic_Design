`timescale 1ns/1ns
module fulladder_tb;
reg [3:0] A, B; 
reg Cin;
wire [3:0] excess3;
wire Cout;

top demo(A, B, Cin, excess3, Cout);

initial
begin
    A = 4'b1001; B = 4'b0111; Cin = 0; #10;
    A = 4'b0000; B = 4'b0001; Cin = 0; #10;
    A = 4'b0001; B = 4'b0001; Cin = 0; #10;
    A = 4'b1111; B = 4'b0100; Cin = 0; #10;
    A = 4'b0011; B = 4'b0001; Cin = 0; #10;
    A = 4'b1110; B = 4'b0111; Cin = 0; #10; 
    A = 4'b0111; B = 4'b1111; Cin = 0; #10;
    A = 4'b0110; B = 4'b0001; Cin = 0; #10;
    A = 4'b0100; B = 4'b0100; Cin = 0; #10;
    A = 4'b1100; B = 4'b1101; Cin = 0; #10;
    A = 4'b1100; B = 4'b1101; Cin = 0; #10;
    A = 4'b0101; B = 4'b0011; Cin = 1; #10;
    $finish;
end

initial
$monitor($time, "A = %b, B = %b, Excess3 = %b, Cout = %b", A, B, excess3, Cout);

endmodule