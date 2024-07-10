`timescale 1ns/1ns
module gate_tb;
reg A, B, C, D, E, F, G; 
wire Z;

logic_gates demo(A, B, C, D, E, F, G, Z);
 
initial
begin
    A=1'b0; B=1'b0; C=1'b0; D=1'b0; E=1'b0; F=1'b0; G=1'b0; #10;
    A=1'b1; B=1'b0; C=1'b1; D=1'b1; E=1'b0; F=1'b1; G=1'b1; #10;
    A=1'b0; B=1'b1; C=1'b0; D=1'b1; E=1'b1; F=1'b1; G=1'b0; #10;
    A=1'b0; B=1'b0; C=1'b1; D=1'b1; E=1'b1; F=1'b0; G=1'b0; #10;
    A=1'b1; B=1'b0; C=1'b1; D=1'b1; E=1'b0; F=1'b0; G=1'b0; #10;
    A=1'b0; B=1'b0; C=1'b0; D=1'b0; E=1'b1; F=1'b0; G=1'b1; #10;
    A=1'b0; B=1'b0; C=1'b1; D=1'b1; E=1'b1; F=1'b1; G=1'b1; #10;
    A=1'b1; B=1'b1; C=1'b0; D=1'b1; E=1'b1; F=1'b0; G=1'b1; #10;
    A=1'b1; B=1'b1; C=1'b1; D=1'b1; E=1'b1; F=1'b1; G=1'b1; #10;
    $finish;
end

initial
$monitor($time, "A = %b, B = %b, C = %b, D = %b, E = %b, F = %b, G = %b, Z = %b", A, B, C, D, E, F, G, Z);

endmodule