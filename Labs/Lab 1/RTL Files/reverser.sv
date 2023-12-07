`timescale 1ns / 1ps

module reverser #(parameter N = 3)(
    input logic [2**N-1:0] pre_reverse,
    input logic en,
    output logic [2**N-1:0] reversed
    );
    
logic [2**N-1:0] reversed_num; 

integer i;    

always_comb
begin
    for(i = 0; i<2**N; i = i+1)
    begin
        reversed_num[i] = pre_reverse[2**N-1-i];
    end
    
end

    
mux_2x1 #(.N(N)) MUX 
    (
    .i0(pre_reverse),  // select == 0
    .i1(reversed_num),   // select == 1
    .s(en),
    .P(reversed)
);       
    
endmodule
