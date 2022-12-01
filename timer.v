`timescale 1ns / 1ps

// Last Modified 12/1/2022 by Laura
// timer starts at 23:59:59:99
// count down timer
module timer(toggle, reset, clk, disp_time);
    
    input toggle, reset, clk;
    output reg [23:0] disp_time;
    
    reg [4:0] hr = 0;
    reg [5:0] min = 0;
    reg [5:0] sec = 0;
    reg [6:0] ms = 0;
    
    always @ (posedge reset) begin
        // reset timer to starting point
        if (reset) begin
            hr <= 5'b10111;
            min <= 6'b111011;
            sec <= 6'b111011;
            ms <= 7'b1100100;
        end
    end
    
    always @ (posedge clk) begin
        // while the timer is not set to stop, keep counting
        if (toggle) begin
            ms <= ms - 1'b1;
            end
    end
    
    always @ (*) begin
        // if we count 100ms, decrement the second
        if (ms == 0) begin
            ms <= 7'b1100100;
            sec <= sec - 1'b1;
        end
        else if (sec == 0) begin
            sec <= 6'b111011;
            min <= min - 1'b1;
        end
        else if (min == 0) begin
            min <= 6'b111011;
            hr <= hr - 1'b1;
        end
        else if (hr == 0) begin 
            // stop the timer
            ms <= 0;
            sec <= 0;
            min <= 0;
            hr <= 0;
        end
        
        disp_time <= {hr, min, sec, ms};
        
    end
   

endmodule
