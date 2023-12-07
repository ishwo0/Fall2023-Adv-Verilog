`timescale 1ns / 1ps


module param_leftright_shifter_TB(

    );
    
    
logic [7:0] num;
logic [2:0] shift;
logic [7:0] result_right;
logic [7:0] result_left;

param_right_shifter #(.N(3)) SUMULATION_RIGHT
    (
    .num(num),
    .shift(shift),
    .result(result_right)
    );

param_left_shifter #(.N(3)) SUMULATION_LEFT
    (
    .num(num),
    .shift(shift),
    .result(result_left)
    );
    
    
initial begin
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
end    
    
endmodule
