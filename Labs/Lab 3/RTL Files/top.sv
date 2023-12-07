`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 05:05:07 PM
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
    input logic clk, reset,
    input logic btn,
    output logic [6:0] seg,
    output logic [7:0] AN,
    output logic DP
    );
    
    // signal declaration
    logic db;
    logic btn_tick;
    logic db_tick;
    logic [7:0] btn_count;
    logic [7:0] db_count;
    
    // instantiate modules
    early_debouncer btn_debouncer (
        .clk(clk),
        .reset(reset),
        .sw(btn),
        .db(db)
        );
        
    rising_edge_detect_mealy btn_edge (
        .clk(clk),
        .reset(reset),
        .level(btn),
        .tick(btn_tick)
        );
    
    rising_edge_detect_mealy db_edge (
        .clk(clk),
        .reset(reset),
        .level(db),
        .tick(db_tick)
        );    
        
    bcd_counter_2digits #(.N(8)) btn_counter (
        .clk(clk),
        .reset(reset),
        .en(btn_tick),
        .q(btn_count),
        .max_tick()
        ); 
    
    bcd_counter_2digits #(.N(8)) db_counter (
        .clk(clk),
        .reset(reset),
        .en(db_tick),
        .q(db_count),
        .max_tick()
        ); 
    
    display DISPLAY (
        .clk(clk),
        .reset(reset),
        .digit1(btn_count[3:0]),
        .digit2(btn_count[7:4]),
        .digit3(4'd0),
        .digit4(4'd0),
        .digit5(db_count[3:0]),
        .digit6(db_count[7:4]),
        .digit7(4'd0),
        .digit8(4'd0),
        .seg(seg),
        .an(AN),
        .DP(DP)
        );
    
endmodule
