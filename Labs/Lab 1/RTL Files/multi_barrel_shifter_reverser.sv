`timescale 1ns / 1ps

module multi_barrel_shifter_reverser #(parameter N = 3)(
    input logic [2**N-1:0] num,
    input logic [N-1:0] shift,
    input logic select,
    output logic [2**N-1:0] result
    );
    
logic [2**N-1:0] reversed_num;
logic [2**N-1:0] result_left0;
   
reverser #(.N(N)) REVERSER_PRE
    ( 
    .pre_reverse(num),
    .en(select),            //select == 0 is right shift, select == 1 is left shift
    .reversed(reversed_num)
    );       
    
param_right_shifter #(.N(N)) SHIFTER
    (
    .num(reversed_num),
    .shift(shift),
    .result(result_left0)
    );    

reverser #(.N(N)) REVERSER_POST
    ( 
    .pre_reverse(result_left0),
    .en(select),
    .reversed(result)
    );      
    

    
endmodule
