`timescale 1ns / 1ps


module temp_conversion(
    input logic clk, reset,
    input logic scale,
    input logic [7:0] addr,
    output logic [6:0] seg,
    output logic [7:0] AN,
    output logic DP
    );
    
    // signal declarations
    logic [7:0] data_f, data_c;  
    logic [7:0] data;  
    logic [11:0] tempa_converted,tempb_converted;
    logic [3:0] tempa_letter, tempb_letter;
    logic [3:0] ONEDIGIT;
    
    assign tempa_letter = (scale)? 4'b1100 : 4'b1111;
    assign tempb_letter = (scale)? 4'b1111 : 4'b1100;
    
    ROM #(.fileName("truth_table_fahrenheit.mem")) ROM_F
        (
        .clk(clk),
        .addr(addr),
        .data(data_f)
        );
        
    ROM #(.fileName("truth_table_celsius.mem")) ROM_C
        (
        .clk(clk),
        .addr(addr),
        .data(data_c)        
        );
        
    mux_2x1 #(.N(8)) dataMux
        (
        .i0(data_f),
        .i1(data_c),
        .s(scale),
        .P(data)
        );        
    
    bin2bcd TEMPAFTER_CONVERSION
        (
        .bin(data),
        .bcd(tempa_converted)
        );
        
    bin2bcd TEMPBEFORE_CONVERSION
        (
        .bin(addr),
        .bcd(tempb_converted)
        );   
        
    seven_seg_control SEVSEG
        (
        .clk(clk),
        .reset(reset),
        .digit1(tempb_letter),
        .digit2(tempb_converted[3:0]),
        .digit3(tempb_converted[7:4]),
        .digit4(tempb_converted[11:8]),
        .digit5(tempa_letter),
        .digit6(tempa_converted[3:0]),
        .digit7(tempa_converted[7:4]),
        .digit8(tempa_converted[11:8]),
        .ONE_DIGIT(ONEDIGIT),
        .an(AN)
        );                 
          
    sevSegDec SEVSEGDEC
        (
        .bcd(ONEDIGIT),
        .seg(seg),
        .DP(DP)
        );            
        
    
endmodule
