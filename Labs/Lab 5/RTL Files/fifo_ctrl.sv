`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2023 10:58:30 AM
// Design Name: 
// Module Name: fifo_ctrl
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


module fifo_ctrl
    #(parameter ADDR_WIDTH = 3)
    (
        input logic clk, reset,
        input logic wr, rd,
        output logic full, empty,
        output logic [ADDR_WIDTH - 1: 0] w_addr,
        output logic [ADDR_WIDTH - 1: 0] r_addr
    );
    
    // signal declaration
    logic [ADDR_WIDTH - 1: 0] wr_ptr, wr_ptr_next;
    logic [ADDR_WIDTH - 1: 0] rd_ptr, rd_ptr_next;
    
    logic full_next;
    logic empty_next;
    
    
    // state register segment (sequential)
    always_ff @ (posedge clk, posedge reset)
    begin
        if(reset)
        begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            full <= 1'b0;
            empty <= 1'b1;
        end
        else
        begin
            wr_ptr <= wr_ptr_next;
            rd_ptr <= rd_ptr_next;
            full <= full_next;
            empty <= empty_next;
        end
    end
    
    
    // next state logic (combinational)
    always_comb
    begin
        // assigning default values to registers just incase forgot to (since must have a case for every register at least once so no latches)
        wr_ptr_next = wr_ptr;
        rd_ptr_next = rd_ptr;
        full_next = full;
        empty_next = empty;
        
        // state machine... checking for write and read input signals
        case({wr, rd})
            2'b01:  // when you are reading
            begin
                if(~empty)  // if fifo is not empty
                begin
                    rd_ptr_next = rd_ptr + 1;   // increment the read pointer to the next location
                    full_next = 1'b0;           // since you just read something, you are no longer full
                    if(rd_ptr_next == wr_ptr)   // if you read the last data in the fifo...
                        empty_next = 1'b1;      // declare fifo as empty
                end
                             
                    
            end
            2'b10:  // when you are writing
            begin
                if(~full)   // if fifo is not full
                begin
                    wr_ptr_next = wr_ptr + 2;   // increment the write pointer to the next location
                    empty_next = 1'b0;          // since you just wrote something, you are no longer empty
                    if((wr_ptr_next == rd_ptr - 1)||((wr_ptr_next == rd_ptr)))   // if you wrote into the last memory location...
                        full_next = 1'b1;       // declare the fifo as full
                end
            end
            2'b11:  // when you are reading and writing at the same time
            begin
//                if(empty)   // if fifo is currently empty
//                begin
//                    wr_ptr_next = wr_ptr;   // staying in the same spot
//                    rd_ptr_next = rd_ptr;   // staying in the same spot
//                end
//                else 
                begin
                    wr_ptr_next = wr_ptr + 2;   // increment the write pointer to the next location
                    rd_ptr_next = rd_ptr + 1;   // increment the read pointer to the next location
                    empty_next = 1'b0;
                    if((wr_ptr_next == rd_ptr - 1)||((wr_ptr_next == rd_ptr)))   // if you wrote into the last memory location...
                         full_next = 1'b1;
                end
            end
            
            default: ;  // 2'b00 (when not reading or writing do nothing)
        endcase
        
        
        
        
    end
    
    // output declaration
    assign w_addr = wr_ptr;
    assign r_addr = rd_ptr;
    
endmodule
