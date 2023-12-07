`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2023 01:41:14 PM
// Design Name: 
// Module Name: t_ff
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


module t_ff(
    input logic clk, reset,
    input logic t,
    output logic q
    );
    
    always_ff @ (posedge clk or posedge reset)
    begin
        if (reset)
            q <= 0;
        else
        begin
            if (t)
                q <= ~q;
            else
                q <= q;
        end 
    end    
    
endmodule
