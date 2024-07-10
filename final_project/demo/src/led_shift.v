//do not modify this module
module led_shift(
    input   clk   ,
    input   rst   ,
    input    sw  ,
    output  [3:0] led
    );
    
    wire    clk_div ;
    
    shifter s0(
    .clk    (clk_div),
	.rst	(rst),
    .flag   (sw),
    .out    (led)
    );
    
    clk_div clk_div_0(
    .clk    (clk),
    .rst    (rst),
    .clk_div    (clk_div)
    );
    
    
endmodule
