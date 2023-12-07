`timescale 1ns / 1ps

module param_right_shifter #(parameter N = 3)(
    input [2**N-1:0] num,
    input [N-1:0] shift,
    output [2**N-1:0] result
    );
    
logic [2**N-1:0] s1;
logic [N-1:0] count = 0;
always_comb
begin

    s1 = num;
    
    for (count = 0; count < shift; count = count + 1)
        begin
            s1 = { s1[0], s1[2**N-1:1] };
        end

end

assign result = s1;

endmodule


