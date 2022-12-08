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
    
    always @ (posedge reset) begin
        // reset timer to starting point
        if (reset) begin
            hr <= hr_i;
            min <= min_i;
            sec <= sec_i;
            ms <= ms_i;
        end
    end
    
    always @ (posedge clk) begin
        // while the timer is not set to stop, keep counting
        if (toggle && (disp_time != 27'b000010000010000010000000001)) begin
            ms <= ms - 1'b1;
            out_time <= disp_time;
        end
        else if (disp_time == 27'b000010000010000010000000001) begin
            out_time <= 0;
        end
    end
    
    always @ (*) begin
        // if we count 1000ms, decrement the second
        if ((ms == 0) && (out_time != 0)) begin
            ms <= 10'b1111101000;
            sec <= sec - 1'b1;
        end
        else if ((sec == 0) &&(out_time != 0)) begin
            sec <= 6'b111011;
            min <= min - 1'b1;
        end
        else if ((min == 0) &&(out_time != 0)) begin
            min <= 6'b111011;
            hr <= hr - 1'b1;
        end
        else if ((hr == 0)) begin 
            // stop the timer
            ms <= 0;
            sec <= 0;
            min <= 0;
            hr <= 0;
        end
        
        disp_time <= {hr, min, sec, ms};
    end
   

endmodule
