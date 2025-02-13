`timescale 1ns / 1ps
`default_nettype none

module counter32bit(
    input wire clk,
    output wire [31:0] val
    );
    // output 25-28 bit
    
    logic [63:0] count = 64'b0;
    assign val = count[51:19]; // nth bit changes at clockspeed / 2^n, where n is the first bit
    // if bits were not indexed at 0, 2^n would need adjusted by 1
        
    always_ff @(posedge clk)
        count <= count + 1'b 1;
    
endmodule