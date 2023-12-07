`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 05:29:52 PM
// Design Name: 
// Module Name: binary_counter_bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module binary_counter_bcd
    # (parameter N = 4)
    (
    input logic clk, reset,
    input logic en,
    output logic [N-1:0] q,
    output logic max_tick
    );
                                  
        
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
    assign r_next = (en)? 
                        ( (r_reg == 9)? 4'd0 : r_reg + 1 ) 
                        : r_reg;
    
    
    // output logic segment
    assign q = r_reg;
    assign max_tick = (r_reg == 9 && en)? 1'b1 : 1'b0;
    
endmodule
