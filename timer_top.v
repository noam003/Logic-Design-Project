`timescale 1ns / 1ps


module timer_top(toggle, reset, clk, add_one, add_ten, ms_sw, s_sw, min_sw, hr_sw, out_time);

    input toggle, reset, clk, add_one, add_ten, ms_sw, s_sw, min_sw, hr_sw;
    output [26:0] out_time;
    wire [26:0] start_time;
    wire inc;
    reg [1:0] button_type;
    wire [9:0] ms;
    wire [5:0] sec;
    wire [5:0] min;
    wire [4:0] hr;
    reg button_in;
    
    debouncer DB (.clk(clk),
                    .reset(reset),
                    .button_in(button_in),
                    .button_out(inc));
                    
    count_out CO (.button_in(inc),
                  .button_type(button_type),
                  .ms_sw(ms_sw),
                  .s_sw(s_sw),
                  .min_sw(min_sw),
                  .hr_sw(hr_sw),
                  .reset(reset),
                  .clk(clk),
                  .out(start_time));
    
    user_entry UE (.ms_sw(ms_sw),
                    .s_sw(s_sw),
                    .min_sw(min_sw),
                    .hr_sw(hr_sw),
                    .add_time(start_time),
                    .clk(clk),
                    .reset(reset),
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
              
    always @ (posedge clk or posedge reset) begin
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
