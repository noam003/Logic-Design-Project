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


module top(clk, reset, toggle, add_one, add_ten, select_nonDB, spring_szn, ms_sw, sec_sw, min_sw, hr_sw, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B);
    input clk, reset, spring_szn, toggle, add_one, add_ten, select_nonDB;
    input ms_sw, sec_sw, min_sw, hr_sw;
    output wire VGA_HS, VGA_VS;
    output wire [3:0] VGA_R, VGA_G, VGA_B;
    wire [26:0] time_12hr, time_24hr, timer_out, stopwatch_out, mux_out;
    wire [7:0] hr_bcd, min_bcd, sec_bcd, ms_bcd;
    wire khz_clk;
    wire [1:0] select;
    
    debouncer_select selectDB(.clock(clk), .reset(reset), .button_in(select_nonDB), .button_out(select_in));
    
    counter get_select(.select_in(select_in), .reset(reset), .count(select));
    
    clock_divider_khz khzClk(.clk_i(clk), .clk_o(khz_clk));
    
    clock_12hr clk12(.kh_clk(khz_clk), .spring_szn(spring_szn), .reset(reset), .disp_time(time_12hr));
    clock_24hr clk24(.kh_clk(khz_clk), .spring_szn(spring_szn), .reset(reset), .disp_time(time_24hr));
    timer_top t0(.toggle(toggle), .reset(reset), .clk(khz_clk), .add_one(add_one), .add_ten(add_ten), .ms_sw(ms_sw), .s_sw(sec_sw), .min_sw(min_sw), .hr_sw(hr_sw), .out_time(timer_out));
    stopwatch s0(.clk(khz_clk), .reset(reset), .toggle(toggle), .disp_time(stopwatch_out));
  
    // assign select = 2'b00;
    mux_4to1 mux(.in1(time_12hr), .in2(time_24hr), .in3(timer_out), .in4(stopwatch_out), .select(select), .mux_out(mux_out));
        
    binary_to_bcd msBCD(.bin(mux_out[9:4]), .bcd(ms_bcd));
    binary_to_bcd secBCD(.bin(mux_out[15:10]), .bcd(sec_bcd));
    binary_to_bcd minBCD(.bin(mux_out[21:16]), .bcd(min_bcd)); 
    binary_to_bcd hrBCD(.bin(mux_out[26:22]), .bcd(hr_bcd));  
    
    display d0(.hours(hr_bcd), .min(min_bcd), .sec(sec_bcd), .ms(ms_bcd), .clk(clk), .reset(reset), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B));
    
endmodule
