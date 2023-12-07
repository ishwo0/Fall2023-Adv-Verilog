`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 11:44:53 AM
// Design Name: 
// Module Name: blinker
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


module blinker
    #(parameter BITS = 32)
    (
    input logic clk, reset,
    input logic [BITS-1:0] rate,
    output logic dout
    
    );
    
    // signal declaration
    logic toggle;
    
    
    // instantiate counter
    modulus_counter #(.BITS(BITS)) counter
        (
        .clk(clk),
        .reset(reset),
        .mn(rate),
        .max_tick(toggle)
        );
        
    // instantiate t-ff
    t_ff TFF                            
        (
        .clk(clk),
        .reset(reset),
        .t(toggle),
        .q(dout)
        ); 
    
    
    
endmodule
