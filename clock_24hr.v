`timescale 1ns / 1ps
// Engineer: Noa Margolin
// Module Name: clock_24hr
// Description: Behavioral verilog Digita Ckock that increments every millisecond
// Additional Comments: 1 khz = 1 ms, therefore we input the kh_clk; using active high rst
// spring_season to enable day light adding, off for day light savings

module clock_24hr(kh_clk, spring_szn, reset, disp_time);

    input kh_clk, spring_szn, reset;
    output reg [26:0] disp_time;
    reg [4:0] hr;
    reg [5:0] min;
    reg [5:0] sec;
    reg [9:0] ms;
    
    initial begin
        hr = 0;
        min = 0;
        sec = 0;
        ms = 0;
    end
    
   always @ (spring_szn) begin
        if (spring_szn)
            hr = hr + 1;
        else 
            hr = hr - 1;
   end
    
    always @ (posedge kh_clk or posedge reset) begin
        if (reset) begin
            hr <= 0;
            min <= 0;
            sec <= 0;
            ms <= 0;
        end else if (kh_clk == 1) begin
            ms <= ms + 1; // increment ms
            if (ms == 999) begin
                ms <= 0;
                sec <= sec +1 ; // increment s
                if (sec == 59) begin
                    sec <= 0;
                    min <= min + 1; // increment min
                    if (min == 59) begin
                        min <= 0;
                        hr <= hr + 1; // increment hr
                        if (hr == 23) begin
                            hr <= 0;
                        end
                    end
                end
           end
        end
       disp_time <= {hr,min,sec,ms};   
    end

endmodule
