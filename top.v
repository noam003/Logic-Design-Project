`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 03:49:39 PM
// Design Name: 
// Module Name: top
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


module top(clk, reset, toggle, select, ms_sw, sec_sw, min_sw, hr_sw, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B);
    input clk, reset, toggle;
    input [1:0] select;
    input ms_sw, sec_sw, min_sw, hr_sw;
    output wire VGA_HS, VGA_VS;
    output wire [3:0] VGA_R, VGA_G, VGA_B;
    reg [26:0] time_12hr, time_24hr, timer_out, stopwatch_out, mux_out;
    reg [7:0] hr_bcd, min_bcd, sec_bcd, ms_bcd;
    reg khz_clk;

    
    clock_divider_khz(.clk_i(clk), .clk_o(khz_clk));
    
    clock_12hr clk12(.kh_clk(khz_clk), .reset(reset), .disp_time(time_12hr));
    clock_24hr clk24(.kh_clk(khz_clk), .reset(reset), .disp_time(time_24hr));
    timer_top t0(.toggle(toggle), .reset(reset), .clk(khz_clk), .ms_sw(ms_sw), .sec_sw(sec_sw), .min_sw(min_sw), .hr_sw(hr_sw), .out_time(timer_out));
    stopwatch s0(.clk(khz_clk), .reset(reset), .toggle(toggle), .disp_time(stopwatch_out));
    
    always @ (*) begin
        case (select)
            2'b00: mux_out <= time_12hr;
            2'b01: mux_out <= time_24hr;
            2'b10: mux_out <= timer_out;
            2'b11: mux_out <= stopwatch_out;
        endcase
    end //always     
        
    binary_to_bcd msBCD(.bin(mux_out[9:4]), .bcd(ms_bcd));
    binary_to_bcd secBCD(.bin(mux_out[15:10]), .bcd(sec_bcd));
    binary_to_bcd minBCD(.bin(mux_out[21:16]), .bcd(min_bcd)); 
    binary_to_bcd hrBCD(.bin(mux_out[26:22]), .bcd(hr_bcd));  
    
    display d0(.hours(hr_bcd), .min(min_bcd), .sec(sec_bcd), .ms(ms_bcd), .clk(clk), .reset(reset), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));
    
endmodule
