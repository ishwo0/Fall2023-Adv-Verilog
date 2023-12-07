`timescale 1ns / 1ps

module chu_blinker_TB();

    // declaration
    localparam T = 10;  // clk period
    
    logic clk, reset;
//    logic [15:0] rate;
    logic [3:0] dout;
    logic cs;
      logic read;
      logic write;
      logic [4:0] addr;
      logic [31:0] wr_data;
     logic [31:0] rd_data;
    
    
    // instantiate uut
    chu_blinker #(.W(4)) UUT (.*);
    
    
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
        write = 1;
        cs = 1;
        wr_data = 'd5_000;
        addr = 4'b0010;
        
    end

endmodule
