`timescale 1ns / 1ps

module ROM
    #(parameter fileName = "truth_table_fahrenheit.mem")
    (
    input logic clk,
    input logic [7:0] addr,
    output logic [7:0] data
    );
    
    // signal declaration
    (*rom_style = "block" *)logic [7:0] memory [0:2**8 - 1];
    
    initial
        $readmemb(fileName, memory);
    
    always_ff @ (posedge clk)
            data <= memory[addr];
    
endmodule
