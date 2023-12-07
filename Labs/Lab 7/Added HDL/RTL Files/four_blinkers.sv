`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2023 12:13:47 PM
// Design Name: 
// Module Name: four_blinkers
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


module four_blinkers
    #(parameter BITS = 32)
    (
    input logic clk, reset,
    input logic [BITS-1:0] rate0, rate1, rate2, rate3,
    output logic [3:0] dout
    );
    
    
    // instantiate blinkers
    blinker #(.BITS(BITS)) blinker_0
        (
        .clk(clk),
        .reset(reset),
        .rate(rate0),
        .dout(dout[0])
        );
        
    blinker #(.BITS(BITS)) blinker_1
        (
        .clk(clk),
        .reset(reset),
        .rate(rate1),
        .dout(dout[1])
        );
        
    blinker #(.BITS(BITS)) blinker_2
        (
        .clk(clk),
        .reset(reset),
        .rate(rate2),
        .dout(dout[2])
        );
        
    blinker #(.BITS(BITS)) blinker_3
        (
        .clk(clk),
        .reset(reset),
        .rate(rate3),
        .dout(dout[3])
        );
    
    
endmodule
