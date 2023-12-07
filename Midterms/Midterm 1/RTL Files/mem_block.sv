`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2022 07:29:58 PM
// Design Name: 
// Module Name: mem_block
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


module mem_block(
    input logic clk, 
    input logic we, //write enable
    input logic [11:0] addr,
    input logic [3:0] din,
    output logic [3:0] dout
    );
    
    // TODO: Write your code here 
    // DO NOT CHANGE THE MODULE INTERFACE
    
    // signal declaration
    logic [3:0] ram_we_decoder;
    logic [3:0] dout0, dout1, dout2, dout3;
    
    // instantiate modules
    decoder_2x4 DECODER_FOR_RAMS 
        (
        .in(addr[11:10]),
        .out(ram_we_decoder)
        );
        
    ram_1port #(.ADDR_WIDTH(10), .DATA_WIDTH(4)) RAM1K_0
        (
        .clk(clk),
        .we(we & ram_we_decoder[0]),
        .addr(addr),
        .din(din),
        .dout(dout0)
        );
        
    ram_1port #(.ADDR_WIDTH(10), .DATA_WIDTH(4)) RAM1K_1
        (
        .clk(clk),
        .we(we & ram_we_decoder[1]),
        .addr(addr),
        .din(din),
        .dout(dout1)
        );
        
    ram_1port #(.ADDR_WIDTH(10), .DATA_WIDTH(4)) RAM1K_2
        (
        .clk(clk),
        .we(we & ram_we_decoder[2]),
        .addr(addr),
        .din(din),
        .dout(dout2)
        );
    
    ram_1port #(.ADDR_WIDTH(10), .DATA_WIDTH(4)) RAM1K_3
        (
        .clk(clk),
        .we(we & ram_we_decoder[3]),
        .addr(addr),
        .din(din),
        .dout(dout3)
        );
        
    mux_4x1 #(.BITS(4)) MUX
        (
        .in0(dout0),
        .in1(dout1),
        .in2(dout2),
        .in3(dout3),
        .select(addr[11:10]),
        .out(dout)
        );
    
    
endmodule