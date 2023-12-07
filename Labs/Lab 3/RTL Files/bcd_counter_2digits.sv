`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 05:33:40 PM
// Design Name: 
// Module Name: bcd_counter_2digits
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


module bcd_counter_2digits
    # (parameter N = 8)
    (
    input logic clk, reset,
    input logic en,
    output logic [N-1:0] q,
    output logic max_tick
    );
    
    // signal declaration
    logic m_tick_digit1;
//    logic max_tick_digit2;
//    and (max_tick, m_tick_digit1, max_tick_digit2);
    
    binary_counter_bcd #(.N(4)) digit_one (
        .clk(clk),
        .reset(reset),
        .en(en),
        .q(q[3:0]),
        .max_tick(m_tick_digit1)
        ); 
    
    binary_counter_bcd #(.N(4)) digit_two (
        .clk(clk),
        .reset(reset),
        .en(m_tick_digit1),
        .q(q[7:4]),
        .max_tick(max_tick)
        ); 
endmodule
