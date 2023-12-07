`timescale 1ns / 1ps

module blinker_tb();

    // declaration
    localparam T = 10;  // clk period
    
    logic clk, reset;
    logic [15:0] rate;
    logic dout;
    
    
    // instantiate uut
    blinker UUT (.*);
    
    
    // test vectors
    
    // clock (period = 10ns)
    always
    begin
        clk = 1'b0;     // clk initially set to 0
        #( T / 2 );     // after T/2 ns (5ns)
        clk = 1'b1;     // clk set to 1
        #( T / 2 );     // another T/2 ns before looping
    end
    
    // initial reset
    initial
    begin
        reset = 1'b1;
        @(negedge clk)
            reset = 1'b0;
    end
    
    initial
    begin
        rate = 16'd10_000;
    end
    
endmodule
