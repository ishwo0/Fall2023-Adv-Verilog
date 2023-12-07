`timescale 1ns / 1ps

module multi_barrel_shifter_mux #(parameter N = 3)(
    input logic [2**N-1:0] num,
    input logic [N-1:0] shift,
    input logic select,
    output logic [2**N-1:0] result
    );
    
logic [2**N-1:0] result_right, result_left;    
    
mux_2x1 #(.N(N)) MUX
    (
    .i0(result_right),  // select == 0
    .i1(result_left),   // select == 1
    .s(select),
    .P(result)
);        
    
    
param_right_shifter #(.N(N)) RIGHT_SHIFTER
    (
    .num(num),
    .shift(shift),
    .result(result_right)    
    );

param_left_shifter #(.N(N)) LEFT_SHIFTER
    (
    .num(num),
    .shift(shift),
    .result(result_left)
    );
    
    
endmodule
