`timescale 1ns / 1ps


module mod_counter
    # (parameter M = 10)
    (
    input logic clk, reset,
    output logic [N-1:0] q,
    output logic max_tick
    );
    
    // constant declaration (N represents the number of neccessary bits for the counter)    
    localparam N = $clog2(M);
                                             
        
    // signal declaration
    logic [N - 1:0] r_reg, r_next;
    
    
    // register segment
    always_ff @ (posedge clk, posedge reset)
    begin
        if (reset)
            r_reg <= 0;
        else
            r_reg <= r_next;
         
    end
    
    
    // next-state logic segment
    assign r_next = (r_reg == (M - 1))? 0 : r_reg + 1;
    
    
    // output logic segment
    assign q = r_reg;
    assign max_tick = (r_reg == (M - 1))? 1'b1 : 1'b0;
        
    
    
endmodule
