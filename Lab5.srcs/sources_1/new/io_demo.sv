`timescale 1ns / 1ps
`default_nettype none

module io_demo(
	input wire clk,
	input wire ps2_data,
	input wire ps2_clk,
	output wire [7:0] segments,
   	output wire [7:0] digitselect,
   	output wire audPWM,
   	output wire audEn 
   );
        
   wire [31:0] keyb_char;
   logic [31:0] period; //shouldn't be ff
   
   wire [31:0] notes_periods[0:7] = {454545, 404953, 382225, 340524, 303372, 286345, 255105, 227273};
   
   wire [7:0] key_is_pressed, most_recent_key;
   
   assign key_is_pressed = keyb_char[15:8];
   assign most_recent_key = keyb_char[7:0];
   
   assign audEn = key_is_pressed == 'hF0 ? 0 : 1;
   
   always_comb
        case (most_recent_key)
            'h1c: period <= notes_periods[0];
            'h1b: period <= notes_periods[1];
            'h23: period <= notes_periods[2];
            'h2b: period <= notes_periods[3];
            'h34: period <= notes_periods[4];
            'h33: period <= notes_periods[5];
            'h3b: period <= notes_periods[6];
            'h42: period <= notes_periods[7];
            default: period <= 32'b 0;
        endcase 
   
    montek_sound_generator snd(clk, period, audPWM);
	keyboard keyb(clk, ps2_clk, ps2_data, keyb_char);          // receive keyb_char from keyboard
	display8digit disp(keyb_char, clk, segments, digitselect); // display keyb_char on the 8-digit display
endmodule
