`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2023 09:14:13 PM
// Design Name: 
// Module Name: temp_conversion_TB
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


module temp_conversion_TB();

// declaration
localparam T = 10;  // clk period

logic clk, reset;
logic scale;
logic [7:0] addr;
logic [6:0] seg;
logic [7:0] AN;
logic DP;



// instantiate uut
temp_conversion UUT (.*);


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
scale = 0;
addr = 8'd0;
#80000
addr = 8'd38;
#80000
addr = 8'd150;
#80000
scale = 1;
addr = 8'd32;
#80000
addr = 8'd100;
#80000
addr = 8'd230;
#80000
addr = 8'd5;
end

endmodule
