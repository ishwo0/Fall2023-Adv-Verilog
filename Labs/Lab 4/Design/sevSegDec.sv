`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2023 12:04:02 PM
// Design Name: 
// Module Name: sevSegDec
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


module sevSegDec(
    input logic [3:0] bcd,
    output logic [6:0] seg,
    output logic DP
    );
    
    always_comb
    begin
        case(bcd)
            4'd0 : seg = 7'b1000000;
            4'd1 : seg = 7'b1111001;
            4'd2 : seg = 7'b0100100;
            4'd3 : seg = 7'b0110000;
            4'd4 : seg = 7'b0011001;
            4'd5 : seg = 7'b0010010;
            4'd6 : seg = 7'b0000010;
            4'd7 : seg = 7'b1111000;
            4'd8 : seg = 7'b0000000;
            4'd9 : seg = 7'b0010000;
            4'd10 : seg = 7'b0001000;
            4'd11 : seg = 7'b0000011;
            4'd12 : seg = 7'b1000110;
            4'd13 : seg = 7'b0100001;
            4'd14 : seg = 7'b0000110;
            4'd15 : seg = 7'b0001110;
            default : seg = 7'b1111111;
        endcase
    end
    
    assign DP = 1'b1;    
endmodule
