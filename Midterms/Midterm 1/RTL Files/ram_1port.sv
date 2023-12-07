`timescale 1ns / 1ps

module ram_1port
    #(parameter ADDR_WIDTH = 10, DATA_WIDTH = 4)
    (
        input logic clk,
        input logic we,  // write enable
        input logic [ADDR_WIDTH - 1: 0] addr, // address
        input logic [DATA_WIDTH - 1: 0] din,
        output logic [DATA_WIDTH - 1: 0] dout
    );
    
    // signal declaration
    logic [DATA_WIDTH - 1: 0] memory [0: 2**ADDR_WIDTH - 1];
    
    // writing operation (synchronous)
    always_ff @ (posedge clk)
    begin
        if(we)   // if writing is enabled
        begin
            memory[addr] <= din;   // fill memory at specified address with the data
        end
        
        dout <= memory[addr];
    end
    
endmodule
