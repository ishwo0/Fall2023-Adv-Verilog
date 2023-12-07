`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 04:51:12 PM
// Design Name: 
// Module Name: display
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


module display(
    input logic clk, reset,
    input logic [3:0] digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8,
    output logic [6:0] seg,
    output logic [7:0] an,
    output logic DP
    );
    
    // signal declaration
    logic [3:0] ONE_DIGIT;
    
    // instantiate modules
    seven_seg_control SSD_CONTROL (
        .clk(clk),
        .reset(reset),
        .*, 
        .ONE_DIGIT(ONE_DIGIT),
        .an(an)
        );

    seven_seg SSD_DISP (
        .bcd_in(ONE_DIGIT),
        .seg(seg),
        .DP(DP)
        );        
    
endmodule
