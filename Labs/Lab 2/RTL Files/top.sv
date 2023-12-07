`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2023 01:20:35 PM
// Design Name: 
// Module Name: top
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


module top(
    input logic [3:0] m, n,
    input logic clk, reset,
    output logic signal
    );
    
    logic [7:0] multi_mn;               // variable to store result of multiplication
    logic [3:0] mn;                     
    logic toggle;
    logic select;
    assign multi_mn = mn * 10;
    
        
    //timer_10ns #(.M(10)) TIMER
    //    (
    //    .clk(clk),
    //    .reset(reset),
    //    .max_tick(enable)
    //    );    
    
    mux_2x1 #(.N(2)) MUX                // 2x1 mux to select between m or n
        (
        .i0(n),  // select == 0
        .i1(m),   // select == 1
        .s(select),
        .P(mn)
    );    
    
    modulus_counter MNCOUNTER           // modulus counter to count up to m*10 or n*10
        (
        .clk(clk),
        .reset(reset),
        .mn(multi_mn),
        .max_tick(toggle)
        );
        
    t_ff TFF                            // t-ff to toggle signal wave based on counter max tick
        (
        .clk(clk),
        .reset(reset),
        .t(toggle),
        .q(select)
        );    
        
    assign signal = select;    
    
endmodule
