`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2023 11:37:26 AM
// Design Name: 
// Module Name: fifo
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


module fifo
    #(parameter ADDR_WIDTH = 3, DATA_WIDTH = 8)
    (
    input logic clk, reset,
    input logic wr, rd,
    input logic [DATA_WIDTH*2 - 1: 0] w_data,
    output logic [DATA_WIDTH - 1: 0] r_data,
    output logic full, empty
    );
    
    // signal declaration
    logic [ADDR_WIDTH - 1: 0] w_addr, r_addr;
    
    // instantiating RAM
    ram_2port #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) reg_file
        (
        .clk(clk),
        .wr_en(wr & ~full),
        .w_addr(w_addr),
        .r_addr(r_addr),
        .w_data(w_data),
        .r_data(r_data)
        );
    
    // instantiating fifo controller
    fifo_ctrl #(.ADDR_WIDTH(ADDR_WIDTH)) fifo_controller
        (
        .clk(clk),
        .reset(reset),
        .wr(wr),
        .rd(rd),
        .full(full),
        .empty(empty),
        .w_addr(w_addr),
        .r_addr(r_addr)
        ); 
    
    
    
endmodule
