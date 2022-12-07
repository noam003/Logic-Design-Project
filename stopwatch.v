`timescale 1ns / 1ps

//Verilog Stopwatch  -- SUHANI MITRA
module stopwatch(clk, reset, toggle, disp_time);
    input clk, reset, toggle;
    output reg [26:0] disp_time;
    
    //toggle value: 0 = stop, 1 = start
    
    reg [4:0] h = 0;
    reg [5:0] m = 0;
    reg [5:0] s = 0;
    reg [9:0] ms = 0;
    
    //asynchronous reset
    always @ (posedge reset) begin 
        if (reset) begin
            ms <= 0;
            s <= 0;
            m <= 0;
            h <= 0;
        end
    end
    
    always @ (posedge clk or posedge reset) begin
        if (toggle) begin
                ms <= ms +1'b1;
        end
    end
    
    //accounts for fall over bits, i.e. when s = 60, add 1 to m
    always @ (*) begin
        if (ms == 10'b1111101000) begin
            ms <= 0;
            s <= s + 1'b1;
        end
        else if (s == 6'b111100) begin
            ms <= 0;
            s <= 0;
            m <= m + 1'b1;
        end
        else if (m == 6'b111100) begin
            ms <= 0;
            s <= 0;
            m <= 0;
            h <= h + 1'b1;
        end
        else if (h == 5'b11000) begin       //reset everything, max value
            ms <= 0;
            s <= 0;
            m <= 0;
            h <= 0;
        end
        
        disp_time <= {h,m,s,ms};
            
    end
    
    
endmodule
