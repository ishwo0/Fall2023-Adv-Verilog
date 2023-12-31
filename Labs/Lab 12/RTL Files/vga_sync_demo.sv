module vga_sync_demo 
   #(parameter CD= 12)    // color depth
   (
    input  logic clk, reset,
    // stream input
    input  logic[CD-1:0] color_rgb,
    // square size input
    input logic[3:0] square_size,
    // to vga monitor
    output logic hsync, vsync,
    output logic[CD-1:0] rgb,
    // frame counter output
    output logic[10:0] hc, vc
   );

   // localparam declaration
   // vga 640-by-480 sync parameters
   localparam HD = 640;  // horizontal display area
   localparam HF = 16;   // h. front porch
   localparam HB = 48;   // h. back porch
   localparam HR = 96;   // h. retrace
   localparam HT = HD+HF+HB+HR; // horizontal total (800)
   localparam VD = 480;  // vertical display area
   localparam VF = 10;   // v. front porch
   localparam VB = 33;   // v. back porch
   localparam VR = 2;    // v. retrace
   localparam VT = VD+VF+VB+VR; // vertical total (525)
   // signal delaration
   logic [1:0] q_reg;
   logic tick_25M;
   logic[10:0] x, y;
   logic hsync_i, vsync_i, video_on_i;
   logic hsync_reg, vsync_reg;  
   logic [7:0] size;
   logic [CD-1:0] rgb_reg;  

   // body 
   // mod-4 counter to generate 25M-Hz tick
   always_ff @(posedge clk)
      q_reg <= q_reg + 1;
   assign tick_25M = (q_reg == 2'b11) ? 1 : 0;
   // instantiate frame counter
   frame_counter #(.HMAX(HT), .VMAX(VT)) frame_unit
      (.clk(clk), .reset(reset), 
       .sync_clr(0), .hcount(x), .vcount(y), .inc(tick_25M), 
       .frame_start(), .frame_end());
   // horizontal sync decoding
   assign hsync_i = ((x>=(HD+HF)) && (x<=(HD+HF+HR-1))) ? 0 : 1;
   // vertical sync decoding
   assign vsync_i = ((y>=(VD+VF)) && (y<=(VD+VF+VR-1))) ? 0 : 1;
   // display on/off
   assign video_on_i = ((x < HD) && (y < VD)) ? 1: 0;
   
   assign size = (square_size[3]) ? 8'd128 :
                    (square_size[2]) ? 8'd64 :
                        (square_size[1]) ? 8'd32 :
                            (square_size[0]) ? 8'd16 : 0;
   
   
   // buffered output to vga monitor
   always_ff @(posedge clk) begin
      vsync_reg <= vsync_i;
      hsync_reg <= hsync_i;
      if (video_on_i && size != 0)
      begin
        if(y < (240 - size - 1))
        begin
            rgb_reg[11:8] = ~color_rgb[11:8];
            rgb_reg[7:4] = ~color_rgb[7:4];
            rgb_reg[3:0] = ~color_rgb[3:0];
        end
        else if(y < (240 + size + 1))
        begin
        
            if(x < (320 - size - 1))
            begin
                rgb_reg[11:8] = ~color_rgb[11:8];
                rgb_reg[7:4] = ~color_rgb[7:4];
                rgb_reg[3:0] = ~color_rgb[3:0];
            end
            else if(x < (320 + size + 1))
            begin
                rgb_reg[11:8] = color_rgb[11:8];
                rgb_reg[7:4] = color_rgb[7:4];
                rgb_reg[3:0] = color_rgb[3:0];
            end
            else
            begin
                rgb_reg[11:8] = ~color_rgb[11:8];
                rgb_reg[7:4] = ~color_rgb[7:4];
                rgb_reg[3:0] = ~color_rgb[3:0];
            end
            
        end
        else
        begin
            rgb_reg[11:8] = ~color_rgb[11:8];
            rgb_reg[7:4] = ~color_rgb[7:4];
            rgb_reg[3:0] = ~color_rgb[3:0];
        end
      end
      
      else
         rgb_reg <= 0;    // black when display off 
   end
   
   
   
   
   // output 
   assign hsync = hsync_reg;
   assign vsync = vsync_reg;
   assign rgb = rgb_reg;
   assign hc = x;
   assign vc = y;
endmodule