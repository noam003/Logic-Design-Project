`timescale 1ns / 1ps


module timer_top(toggle, reset, clk_khz, clk, add_one, add_ten, ms_sw, s_sw, min_sw, hr_sw, out_time);

    input toggle, reset, clk, clk_khz, add_one, add_ten, ms_sw, s_sw, min_sw, hr_sw;
    output [26:0] out_time;
    wire [26:0] start_time;
    wire inc, count_out;
    wire [3:0] switches;
    reg [1:0] button_type;
    wire [9:0] ms;
    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hr;
    reg button_in;
    
    assign switches = {hr_sw, min_sw, s_sw, ms_sw};
    
    //clk
    debouncer DB (.clk(clk),
                    .reset(reset),
                    .button_in(button_in),
                    .button_out(inc));
                    
    restart_timer_user_entry REUE (.count_in(switches),
                                   .count_out(count_out));
     
    //clk_khz               
    count_out CO (.button_in(inc),
                  .button_type(button_type),
                  .count_in(count_out),
                  .ms_sw(ms_sw),
                  .s_sw(s_sw),
                  .min_sw(min_sw),
                  .hr_sw(hr_sw),
                  .reset(reset),
                  .clk(clk_khz),
                  .out(start_time));
    
    //clk_khz
    user_entry UE (.ms_sw(ms_sw),
                    .s_sw(s_sw),
                    .min_sw(min_sw),
                    .hr_sw(hr_sw),
                    .add_time(start_time),
                    .clk(clk_khz),
                    .reset(reset),
                    .ms_o(ms),
                    .sec_o(sec),
                    .min_o(min),
                    .hr_o(hr));
    //clk_khz       
    timer TR (.toggle(toggle), 
              .ms_i(ms),
              .sec_i(sec),
              .min_i(min),
              .hr_i(hr),
              .reset(reset),
              .clk(clk_khz),
              .out_time(out_time));
    
    always @ (*) begin
        if (add_one) begin
            button_in = add_one;
            button_type = 2'b01;
        end
        else if (add_ten) begin
            button_in = add_ten;
            button_type = 2'b10;
        end
        else begin
            button_in = 0;
            button_type = 2'b00;
        end
    end
                    
endmodule
