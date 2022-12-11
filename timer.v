`timescale 1 ns / 1ps

// Last Modified 12/8/2022 by Laura
// count down timer
module timer(toggle, ms_i, sec_i, min_i, hr_i, reset, clk, out_time);
    
    input toggle, reset, clk;
    input [9:0] ms_i;
    input [5:0] sec_i;
    input [5:0] min_i;
    input [4:0] hr_i;
    output reg [26:0] out_time;
    reg [26:0] disp_time;
    reg [4:0] hr = 0;
    reg [5:0] min = 0;
    reg [5:0] sec = 0;
    reg [9:0] ms = 0;

    
    always @ (posedge clk or posedge reset) begin
        if (reset || !toggle) begin
            hr <= hr_i;
            min <= min_i;
            sec <= sec_i;
            ms <= ms_i;
            out_time <= {hr, min, sec, ms};
        end
        // while the timer is not set to stop, keep counting
       // if we count 1000ms, decrement the second
        else  if (toggle) begin
        
            disp_time = {hr, min, sec, ms};
            if (toggle && (disp_time != 0)) begin
                ms = ms - 1'b1;
                disp_time = {hr, min, sec, ms};
                out_time = disp_time;
            end
            else if (disp_time == 0) begin
                out_time = 0;
            end
            
            if ((ms == 10'b1111111111) && (out_time != 0)) begin
                sec = sec - 1'b1;
                ms = 10'b1111100111;
                if ((sec == 6'b111111) && (out_time != 0)) begin
                    sec = 6'b111011;
                    min = min - 1'b1;
                    if ((min == 6'b111111) && (out_time != 0)) begin
                        min = 6'b111011;
                        hr = hr - 1'b1;
                    end
                end
            end

        end 
    end
    
endmodule
