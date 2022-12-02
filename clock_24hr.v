`timescale 1ns / 1ps
// Engineer: Noa Margolin
// Module Name: clock_24hr
// Description: Behavioral verilog Digita Ckock that increments every millisecond
// Additional Comments: 1 khz = 1 ms, therefore we input the kh_clk; using active high rst


module clock_24hr(kh_clk, reset, disp_time);

    input kh_clk, reset;
    output reg [23:0] disp_time;
    
    reg [4:0] hr = 0;
    reg [5:0] min = 0;
    reg [5:0] sec = 0;
    reg [9:0] ms = 0;
    
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
                            hr = 0;
                        end
                    end
                end
           end
       end
       disp_time <= {hr,min,sec,ms};   
    end
endmodule
