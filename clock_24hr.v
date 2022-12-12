`timescale 1ns / 1ps

// Company: 
// Engineer: Noa Margolin
// Module Name: clock_12hr
// Additional Comments: Basically same design as 24 Hour clock, just increments at hr 12

module clock_24hr(kh_clk, spring_szn, reset, disp_time);

    input kh_clk, spring_szn, reset;
    output reg [26:0] disp_time;
    reg [4:0] hr_reg;
    
    reg [4:0] hr = 0;
    reg [5:0] min = 0;
    reg [5:0] sec = 0;
    reg [9:0] ms = 0;
    reg szn_change;
    
    
    always @ (posedge kh_clk or posedge reset) begin
        if (reset) begin
            hr <= 0;
            min <= 0;
            sec <= 0;
            ms <= 0;
            szn_change <= spring_szn;
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
      hr <= hr_reg;
      disp_time <= {hr,min,sec,ms};  
      szn_change <= spring_szn; 
    end
    
    always @ (*) begin
        case (spring_szn)
            0: begin if (spring_szn == szn_change) begin
                hr_reg = hr;
                end else if (hr == 23) begin
                    hr_reg = 0;
                    end else begin 
                        hr_reg = hr + 1;
                    end
                end
            1:  begin if (spring_szn == szn_change) begin
                hr_reg = hr;
                end else if (hr == 0) begin
                    hr_reg = 23;
                    end else begin 
                        hr_reg = hr - 1;
                    end
                end
       endcase
   end
endmodule
