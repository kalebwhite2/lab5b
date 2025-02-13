`timescale 1ns / 1ps
`default_nettype none

module counter8digit(
    input wire clk,
    output wire [7:0] segments,
    output wire [7:0] digitselect
    );
    
    wire [31:0] val;
    
    counter32bit mycounter(clk, val);
    display8digit mydisplay8digit(val, clk, segments, digitselect);
         
endmodule

