`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2023 10:50:21 AM
// Design Name: 
// Module Name: ram_2port
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


module ram_2port
    #(parameter ADDR_WIDTH = 3, DATA_WIDTH = 8)
    (
        input logic clk,
        input logic wr_en,  // write enable
        input logic [ADDR_WIDTH - 1: 0] r_addr, // reading address
        input logic [ADDR_WIDTH - 1: 0] w_addr, // writing address
        input logic [DATA_WIDTH*2 - 1: 0] w_data,
        output logic [DATA_WIDTH - 1: 0] r_data
    );
    
    // signal declaration
    logic [DATA_WIDTH - 1: 0] memory [0: 2**ADDR_WIDTH - 1];
    
    // writing operation (synchronous)
    always_ff @ (posedge clk)
    begin
        if(wr_en)   // if writing is enabled
        begin
            memory[w_addr] <= w_data[DATA_WIDTH - 1:0];   // fill memory at specified address with the writing data
            memory[w_addr + 1] <= w_data[DATA_WIDTH*2 - 1:DATA_WIDTH ];
        end
    end
    
    // asynchronous reading: read data is always available
    assign r_data = memory[r_addr];
endmodule
