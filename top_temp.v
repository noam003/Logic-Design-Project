`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 04:45:33 PM
// Design Name: 
// Module Name: top_temp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_temp(input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,     
    output wire VGA_HS,       // horizontal sync output
    output wire VGA_VS,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B     // 4-bit VGA blue output

    );
    
    //top_square(.CLK(CLK), .RST_BTN(RST_BTN),.random_num(8'b00000001), .hit(8'b000000000), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS),.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B));
    
    
    display D(.clk(CLK), .reset(RST_BTN),.hours(8'b00100011), .min(8'b00111001), .sec(8'b01011001), .ms(8'b01000100), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS),.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B));
    
endmodule
