`timescale 1ns / 1ps

module chu_blinker
    #(parameter W = 4)  // width of output port
    (
    input  logic clk,
    input  logic reset,
    // slot interface
    input  logic cs,
    input  logic read,
    input  logic write,
    input  logic [4:0] addr,
    input  logic [31:0] wr_data,
    output logic [31:0] rd_data,
    // external port    
    output logic [W-1:0] dout
    );
   
   
    // instantiate blinkers
    four_blinkers #(.BITS(32)) blinkers
        (
        .clk(clk),
        .reset(reset),
        .rate0(buf_reg0),
        .rate1(buf_reg1),
        .rate2(buf_reg2),
        .rate3(buf_reg3),
        .dout(dout)
        );
        
   // declaration
   logic [31:0] buf_reg0, buf_reg1, buf_reg2, buf_reg3;
   logic wr_en;

   // body
   // output buffer register
   always_ff @(posedge clk, posedge reset)
   begin
      if (reset)
      begin
         buf_reg0 <= 0;
         buf_reg1 <= 0;
         buf_reg2 <= 0;
         buf_reg3 <= 0;
      end
      else   
      begin
         if (wr_en0)
            buf_reg0 <= wr_data[31:0];
         if (wr_en1)
            buf_reg1 <= wr_data[31:0];
         if (wr_en2)
            buf_reg2 <= wr_data[31:0];
         if (wr_en3)
            buf_reg3 <= wr_data[31:0];
      end
   end
      
      
   // decoding logic 
   assign wr_en0 = (write && cs && (addr[1:0]==2'b00));
   assign wr_en1 = (write && cs && (addr[1:0]==2'b01));
   assign wr_en2 = (write && cs && (addr[1:0]==2'b10));
   assign wr_en3 = (write && cs && (addr[1:0]==2'b11));
   
   // slot read interface
   assign rd_data =  0;
   
endmodule
       



