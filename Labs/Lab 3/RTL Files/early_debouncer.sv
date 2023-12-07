`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 02:52:16 PM
// Design Name: 
// Module Name: early_debouncer
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


module early_debouncer(
    input logic clk, reset,
    input logic sw,
    output logic db
    );
    
    typedef enum {Zero, Wait0_1, Wait0_2, Wait0_3, One, Wait1_1, Wait1_2, Wait1_3} state_type;
    
    
    // signal declaration
    state_type state_reg, state_next;
    logic m_tick;
    
    // instantiate timer
    mod_counter #(.M(1_000_000)) TIMER_10ms
        (
        .clk(clk),
        .reset(reset),
        .q(),
        .max_tick(m_tick)
        );
    
    // [1] state register
    always_ff @ (posedge clk, posedge reset)
    begin
        if (reset)
            state_reg <= Zero;
        else
            state_reg <= state_next;
    end
    
    // [2] next-state logic
    always_comb
    begin
        case (state_reg)
            Zero:   
                if(sw)
                    state_next = Wait0_1;
                else
                    state_next = Zero;
            Wait0_1:
                if(m_tick)
                    state_next = Wait0_2;
                else
                    state_next = Wait0_1;
            Wait0_2:
                if(m_tick)
                    state_next = Wait0_3;
                else
                    state_next = Wait0_2;
            Wait0_3:
                if(m_tick)
                    if(sw)
                        state_next = One;
                    else
                        state_next = Zero;
                else
                    state_next = Wait0_3;
            One:
                if(sw)
                    state_next = One;
                else
                    state_next = Wait1_1;
            Wait1_1:
                if(m_tick)
                    state_next = Wait1_2;
                else
                    state_next = Wait1_1;
            Wait1_2:
                if(m_tick)
                    state_next = Wait1_3;
                else
                    state_next = Wait1_2;
            Wait1_3:
                if(m_tick)
                    if(~sw)
                        state_next = Zero;
                    else
                        state_next = One;
                else
                    state_next = Wait1_3;
            default: state_next = Zero;
        endcase
            
    end
    
    // [3] Mealy output
    
    
    // [4] Moore output
    assign db = (state_reg == Wait0_1) || (state_reg == Wait0_2) || (state_reg == Wait0_3) || (state_reg == One);
    
    
endmodule
