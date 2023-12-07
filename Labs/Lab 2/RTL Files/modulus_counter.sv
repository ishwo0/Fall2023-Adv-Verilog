`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2023 01:02:32 PM
// Design Name: 
// Module Name: modulus_counter
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


module modulus_counter
    (
    input logic clk, reset,
    input logic [7:0] mn,
    output logic max_tick
    );
    
    // signal declaration
    logic [7:0] r_reg, r_next;      
    logic [7:0] count;
    
    // register segment
    always_ff @ (posedge clk, posedge reset)
    begin
        if (reset)
         begin
            r_reg <= 0;
         end
        else
         begin
            r_reg <= r_next;
         end
    end    
        
    // next state logic
    assign r_next = (r_reg == mn-1)? 8'd0 : r_reg + 1;      // if at max count, reset to 0, else increment
    assign count = r_reg;
        
        
    //output logic
    assign max_tick = (r_reg == mn-1)? 1'b1 : 1'b0;         // if at max count, set to 1, else set to 0
    
endmodule
