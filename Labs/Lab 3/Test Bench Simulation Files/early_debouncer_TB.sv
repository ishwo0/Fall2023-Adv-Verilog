`timescale 1ns / 1ps

module early_debouncer_TB( );

// declaration
localparam T = 10;  // clk period

logic clk, reset;
logic sw;
logic db;


// instantiate uut
early_debouncer UUT (.*);


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
    sw = 0;
    repeat(5) #1000000 sw = ~sw;
    #29000000
    repeat(5) #1000000 sw = ~sw;

end





endmodule
