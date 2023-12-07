`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2023 01:29:51 PM
// Design Name: 
// Module Name: top_TB
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


module top_TB( );

    // declaration
    localparam T = 10;  // clk period
    
    logic clk, reset;
    logic [3:0] m, n;
    logic signal;
    
    
    // instantiate uut
    top UUT (.*);
    
    
    // test vectors
    
    // clock (period = 10ns)
    always
    begin
        clk = 1'b0;     // clk initially set to 0
        #( T / 2 );     // after T/2 ns (5ns)
        clk = 1'b1;     // clk set to 1
        #( T / 2 );     // another T/2 ns before looping
    end
    
    // initial reset
    initial
    begin
        reset = 1'b1;
        @(negedge clk)
            reset = 1'b0;
    end
    
    initial
    begin
        m = 3'd1;
        n = 3'd1;
        #995
        m = 3'd2;
        n = 3'd2;
        #1260
        m = 3'd4;
        n = 3'd3;
    end

endmodule
