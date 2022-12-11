`timescale 1ns / 1ps

module user_entry(ms_sw, clk, reset, s_sw, min_sw, hr_sw, add_time, ms_o, sec_o, min_o, hr_o);
    input ms_sw, s_sw, min_sw, hr_sw, clk , reset; // input switches
    input [3:0] add_time; // input button
    output reg [9:0] ms_o;
    output reg [5:0] sec_o;
    output reg [5:0] min_o;
    output reg [4:0] hr_o;
    
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            ms_o = 0;
            sec_o = 0;
            min_o = 0;
            hr_o = 0;
        end
        else if (ms_sw) begin
            ms_o = ms_o + add_time;
            if (ms_o > 10'b1111101000)
                ms_o = ms_o - 10'b1111101000;
        end else if (s_sw) begin
            sec_o = sec_o + add_time;
            if (sec_o > 6'b111011)
                sec_o = sec_o - 6'b111011;
        end else if (min_sw) begin
           min_o = min_o + add_time;
           if (min_o > 6'b111011)
                min_o = min_o - 6'b111011;
        end else if (hr_sw) begin
            hr_o = hr_o + add_time;
            if (hr_o > 6'b111011)
                hr_o = hr_o - 6'b111011;
        end
    end
endmodule
