`timescale 1ns / 1ps
`default_nettype none

module counter4digit(
    input wire clk,
    output wire [7:0] segments,
    output wire [7:0] digitselect
    );
    
    wire [15:0] val;
    
    counter mycounter(clk, val);
    display4digit mydisplay4digit(val, clk, segments, digitselect);
         
endmodule
