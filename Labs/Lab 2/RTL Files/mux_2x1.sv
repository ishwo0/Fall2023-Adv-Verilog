`timescale 1ns / 1ps


module mux_2x1 #(parameter N = 2)(
        input logic [2**N-1:0]  i0, i1,
        input logic s,
        output logic [2**N-1:0] P
      
    );
    
    assign P = s ?i1:i0;
endmodule
