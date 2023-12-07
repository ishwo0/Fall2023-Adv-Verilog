`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2023 11:57:24 AM
// Design Name: 
// Module Name: fifo_TB
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


module fifo_TB();

// signal declaration
localparam T = 10;  // clk period
localparam DATA_WIDTH = 8;
localparam ADDR_WIDTH = 3;

logic clk, reset;
logic wr, rd;
logic [DATA_WIDTH*2 - 1: 0] w_data; 
logic [DATA_WIDTH - 1: 0] r_data;
logic full, empty;


// instantiate uut
fifo #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) UUT (.clk(clk), .reset(reset), .*);


// clock (period = 10ns)
always
begin
    clk = 1'b1;     // clk initially set to 1
    #( T / 2 );     // after T/2 ns (5ns)
    clk = 1'b0;     // clk set to 1
    #( T / 2 );     // another T/2 ns before looping
end

// initial reset
initial
begin
    reset = 1'b1;
    rd = 1'b0;
    wr = 1'b0;
    @(negedge clk);
    reset = 1'b0;
end

// test vectors
initial
begin
    //-----------------------EMPTY--------------------------
    // write
    @(negedge clk);
    w_data = 16'hff0f;
    wr = 1'b1;
    @(negedge clk);
    wr = 1'b0;
    
    // write
    repeat (2) @(negedge clk);
    w_data = 16'haabb;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
    
    // write
    repeat (2) @(negedge clk);
    w_data = 16'hcdef;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
    
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
    
    // write
    repeat (2) @(negedge clk);
    w_data = 16'h1234;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
    
    // write
    repeat (2) @(negedge clk);
    w_data = 16'h5678;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
        
//    // write
//    repeat (1) @(negedge clk);
//    w_data = 8'd9;
//    wr = 1'b1;
//    @(negedge clk)
//        wr = 1'b0;    
        
//    // write
//    repeat (1) @(negedge clk);
//    w_data = 8'd6;
//    wr = 1'b1;
//    @(negedge clk)
//        wr = 1'b0;
        
//    // write
//    repeat (1) @(negedge clk);
//    w_data = 8'd1;
//    wr = 1'b1;
//    @(negedge clk)
//        wr = 1'b0;
        
//    // write
//    repeat (1) @(negedge clk);
//    w_data = 8'd3;
//    wr = 1'b1;
//    @(negedge clk)
//        wr = 1'b0;
    
    //------------------------FULL------------------------
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // read
    repeat (2) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
        
    // read and write
    repeat (1) @(negedge clk);
    w_data = 16'habcd;
    wr = 1'b1;
    rd = 1'b1;
    @(negedge clk)
        wr = 1'b0;
        rd = 1'b0;
        
    // read
    repeat (1) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // write
    repeat (1) @(negedge clk);
    w_data = 16'h26a7;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
        
    // write
    repeat (1) @(negedge clk);
    w_data = 16'h9821;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
        
    // write
    repeat (1) @(negedge clk);
    w_data = 16'h1234;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
        
    // read and write
    repeat (1) @(negedge clk);
    w_data = 16'h5678;
    wr = 1'b1;
    rd = 1'b1;
    @(negedge clk)
        wr = 1'b0;
        rd = 1'b0;
        
    // read
    repeat (1) @(negedge clk);
    rd = 1'b1;
    @(negedge clk)
        rd = 1'b0;
        
    // write
    repeat (2) @(negedge clk);
    w_data = 16'hcdef;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
    
    // write
    @(negedge clk);
    w_data = 16'hff0f;
    wr = 1'b1;
    @(negedge clk);
    wr = 1'b0;
    
    // write
    repeat (2) @(negedge clk);
    w_data = 16'haabb;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
    
    // write
    repeat (2) @(negedge clk);
    w_data = 16'hcdef;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
        
    // write
    repeat (2) @(negedge clk);
    w_data = 16'h1234;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
    
    // write
    repeat (2) @(negedge clk);
    w_data = 16'h5678;
    wr = 1'b1;
    @(negedge clk)
        wr = 1'b0;
    
    
    
    
    
    
    
    
end


endmodule
