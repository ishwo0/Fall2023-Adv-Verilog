`timescale 1ns / 1ps


module reverser_TB(

    );
    
logic [7:0] in;
logic select;
logic [7:0] out;
    
reverser #(.N(3)) REVERSER_TB
    ( 
    .pre_reverse(in),
    .en(select),
    .reversed(out)
    );   
    
initial begin
select = 0;
in = 8'b01010101;
#200
select = 1;

end    
endmodule
