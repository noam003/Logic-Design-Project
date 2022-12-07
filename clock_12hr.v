`timescale 1ns / 1ps

// Company: 
// Engineer: Noa Margolin
// Module Name: clock_12hr
// Additional Comments: Basically same design as 24 Hour clock, just increments at hr 12

module clock_12hr(kh_clk, reset, disp_time);

    input kh_clk, reset;
    output reg [23:0] disp_time;
    
    reg [4:0] hr = 0;
    reg [5:0] min = 0;
    reg [5:0] sec = 0;
    reg [9:0] ms = 0;
    
    
    //use the switch buttons to act as a 16 bit wide binary input number
    //maybe one switch multiplies the #??
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
                        if (hr == 11) begin
                            hr <= 0;
                        end
                    end
                end
           end
       end
       disp_time <= {hr,min,sec,ms};   
    end
endmodule

