`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2023 12:10:25 PM
// Design Name: 
// Module Name: seven_seg_control
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


module seven_seg_control(
    input logic clk, reset,
    input logic [3:0] digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8,
    output logic [3:0] ONE_DIGIT,
    output logic [7:0] an
    );
    
    // signal declarations
    logic m_tick;
    logic [2:0] count_reg, count_next;
    
    // instantiate timer (for human eye visibility)
    mod_counter #(.M(1_000)) TIMER
        (
        .clk(clk),
        .reset(reset),
        .q(),
        .max_tick(m_tick)
        );    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
    //  SLOW COUNTER SEGMENT START
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
    
    // register segment
    always_ff @ (posedge clk, posedge reset)
    begin
        if (reset)
            count_reg <= 0;
        else
            count_reg <= count_next;
         
    end
    
    
    // next-state logic segment
    assign count_next = (m_tick)? count_reg + 1 : count_reg;
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
    //  SLOW COUNTER SEGMENT END
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    
    // output logic segment
    always_comb
    begin
        case(count_reg)
            3'd0 : begin
                        ONE_DIGIT = digit1;
                        an = 8'b11111110;
                   end
            3'd1 : begin
                        ONE_DIGIT = digit2;
                        an = 8'b11111101;
                   end
            3'd2 : begin
                        ONE_DIGIT = digit3;
                        an = 8'b11111011;
                   end
            3'd3 : begin
                        ONE_DIGIT = digit4;
                        an = 8'b11110111;
                   end
            3'd4 : begin
                        ONE_DIGIT = digit5;
                        an = 8'b11101111;
                   end
            3'd5 : begin
                        ONE_DIGIT = digit6;
                        an = 8'b11011111;
                   end
            3'd6 : begin
                        ONE_DIGIT = digit7;
                        an = 8'b10111111;
                   end
            3'd7 : begin
                        ONE_DIGIT = digit8;
                        an = 8'b01111111;
                   end
            default: begin
                        ONE_DIGIT = 4'd14;
                        an = 8'b11111111;
                     end
        endcase
    end
    
endmodule
