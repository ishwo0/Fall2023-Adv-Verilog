`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2023 12:10:58 PM
// Design Name: 
// Module Name: seven_seg_control_TB
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


module seven_seg_control_TB();


// declaration
localparam T = 10;  // clk period

logic clk, reset;
logic [3:0] digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8;
logic [3:0] ONE_DIGIT;
logic [7:0] an;


// instantiate uut
seven_seg_control UUT (.*);


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
digit1 = 0;
digit2 = 1;
digit3 = 2;
digit4 = 3;
digit5 = 4;
digit6 = 5;
digit7 = 6;
digit8 = 7;

end

endmodule
