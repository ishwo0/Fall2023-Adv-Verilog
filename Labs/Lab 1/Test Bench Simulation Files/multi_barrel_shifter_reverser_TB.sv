`timescale 1ns / 1ps


module multi_barrel_shifter_reverser_TB(

    );
logic [7:0] num;
logic [2:0] shift;
logic select;
logic [7:0] result;    
    
    
    multi_barrel_shifter_reverser #(.N(3)) multi_barrel_shifter_reverser_TB
    (
    .num(num),
    .shift(shift),
    .select(select),
    .result(result)
    );

initial begin
select = 1;
num = 8'b1101_0010;
shift = 3'b001;
#200
shift = 3'b010;
#200
shift = 3'b011;
#200
shift = 3'b100;
#200
shift = 3'b101;
#200
shift = 3'b110;
#200
shift = 3'b111;
#400
select = 0;
shift = 3'b001;
#200
shift = 3'b010;
#200
shift = 3'b011;
#200
shift = 3'b100;
#200
shift = 3'b101;
#200
shift = 3'b110;
#200
shift = 3'b111;
end        
        
endmodule
