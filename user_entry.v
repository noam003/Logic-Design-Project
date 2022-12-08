`timescale 1ns / 1ps

module user_entry(ms_sw, s_sw, min_sw, hr_sw, add_time, toggle, ms_o, sec_o, min_o, hr_o);
    input ms_sw, s_sw, min_sw, hr_sw, toggle; // input switches
    input add_time; // input button
    output reg [9:0] ms_o;
    output reg [5:0] sec_o;
    output reg [5:0] min_o;
    output reg [4:0] hr_o;
    
    always @ (*) begin
        if (ms_sw && !toggle) begin
            ms_o <= ms_o + add_time;
        end else if (s_sw && !toggle) begin
            sec_o <= sec_o + add_time;
        end else if (min_sw && !toggle) begin
            min_o <= min_o + add_time;
        end else if (hr_sw && !toggle) begin
            hr_o <= hr_o + add_time;
        end
    end
endmodule
