`timescale 1ns / 1ps


module timer_top(toggle, reset, clk, add_one, add_ten, ms_sw, s_sw, min_sw, hr_sw, out_time);

    input toggle, reset, clk, add_one, add_ten, ms_sw, s_sw, min_sw, hr_sw;
    output [26:0] out_time;
    wire [26:0] start_time;
    wire inc;
    wire [1:0] add_type;
    wire [9:0] ms;
    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hr;
    
    debouncer DB (.clk(clk),
                    .reset(reset),
                    .button_in_one(add_one),
                    .button_in_ten(add_ten),
                    .toggle(toggle),
                    .button_out(inc),
                    .button_type(add_type));
                    
    count_out CO (.button_in(add_type),
                  .out(start_time));
    
    user_entry UE (.ms_sw(ms_sw),
                    .s_sw(s_sw),
                    .min_sw(min_sw),
                    .hr_sw(hr_sw),
                    .toggle(toggle),
                    .add_time(start_time),
                    .ms_o(ms),
                    .sec_o(sec),
                    .min_o(min),
                    .hr_o(hr));
                
    timer TR (.toggle(toggle), 
              .ms_i(ms),
              .sec_i(sec),
              .min_i(min),
              .hr_i(hr),
              .reset(reset),
              .clk(clk),
              .out_time(out_time));
                    
endmodule
