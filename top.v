`timescale 1ns / 1ps


module top(clk, reset, toggle, add_one, add_ten, select_nonDB, spring_szn, ms_sw, sec_sw, min_sw, hr_sw, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B);
    input clk, reset, spring_szn, toggle, add_one, add_ten, select_nonDB;
    input ms_sw, sec_sw, min_sw, hr_sw;
    output wire VGA_HS, VGA_VS;
    output wire [3:0] VGA_R, VGA_G, VGA_B;
    wire [26:0] time_12hr, time_12hr_temp, time_24hr, timer_out, stopwatch_out, mux_out;
    wire [7:0] hr_bcd, min_bcd, sec_bcd, ms_bcd;
    wire khz_clk;
    wire [1:0] select;
    wire [1:0] select_in;
    wire [3:0] red_b, blue_b, green_b, red_r, blue_r, green_r;
    wire hs_r, vs_r, hs_b, vs_b;
    reg [3:0] VGA_R_temp, VGA_B_temp;
    
    debouncer_select selectDB(.clock(clk), .reset(reset), .button_in(select_nonDB), .button_out(select_in));
    
    counter get_select(.select_in(select_in), .reset(reset), .count(select));
    
    clock_divider_khz khzClk(.clk_i(clk), .clk_o(khz_clk));
    
    clock_12hr clk12(.kh_clk(khz_clk), .spring_szn(spring_szn), .reset(reset), .disp_time(time_12hr_temp));
    clock_24hr clk24(.kh_clk(khz_clk), .spring_szn(spring_szn), .reset(reset), .disp_time(time_24hr));
    timer_top t0(.toggle(toggle), .reset(reset), .clk_khz(khz_clk), .clk(clk), .add_one(add_one), .add_ten(add_ten), .ms_sw(ms_sw), .s_sw(sec_sw), .min_sw(min_sw), .hr_sw(hr_sw), .out_time(timer_out));
    stopwatch s0(.clk(khz_clk), .reset(reset), .toggle(toggle), .disp_time(stopwatch_out));
  
    twelve_converter TC(.clk(khz_clk), .time_in(time_12hr_temp), .time_out(time_12hr));
  
    // assign select = 2'b00;
    mux_4to1 mux(.in1(time_12hr), .in2(time_24hr), .in3(stopwatch_out), .in4(timer_out), .select(select), .mux_out(mux_out));
        
    binary_to_bcd msBCD(.bin(mux_out[9:3]), .bcd(ms_bcd));
    binary_to_bcd secBCD(.bin(mux_out[15:10]), .bcd(sec_bcd));
    binary_to_bcd minBCD(.bin(mux_out[21:16]), .bcd(min_bcd)); 
    binary_to_bcd hrBCD(.bin(mux_out[26:22]), .bcd(hr_bcd));  
    
    display d0(.hours(hr_bcd), .min(min_bcd), .sec(sec_bcd), .ms(ms_bcd), .clk(clk), .reset(reset), .VGA_HS(hs_r), .VGA_VS(vs_r), .VGA_R(red_r), .VGA_G(green_r), .VGA_B(blue_r));
    display_blue d1(.hours(hr_bcd), .min(min_bcd), .sec(sec_bcd), .ms(ms_bcd), .clk(clk), .reset(reset), .VGA_HS(hs_b), .VGA_VS(vs_b), .VGA_R(red_b), .VGA_G(green_b), .VGA_B(blue_b));
    
    assign VGA_HS = hs_r;
    assign VGA_VS = vs_r;
    assign VGA_R = VGA_R_temp;
    assign VGA_B = VGA_B_temp;
    assign VGA_G = green_r;
    
    always @ (posedge clk) begin
        if (select == 2'b01) begin
            VGA_B_temp <= blue_b;
            VGA_R_temp <= 0;
        end else
            VGA_B_temp <= 0;
            VGA_R_temp <= red_r;
    end
    
endmodule
