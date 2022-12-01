`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2022 03:35:20 PM
// Design Name: 
// Module Name: stopwatch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//Verilog Stopwatch  -- SUHANI MITRA
module stopwatch(clk, reset, toggle, disp_time);
    input clk, reset, toggle;
    output reg [23:0] disp_time;
    
    //toggle value: 0 = stop, 1 = start
    
    reg [4:0] h = 0;
    reg [5:0] m = 0;
    reg [5:0] s = 0;
    reg [6:0] ms = 0;
    
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
        if (ms == 7'b1100100) begin
            ms <= 0;
            s <= s + 'b1;
        end
        else if (s == 'b111100) begin
            s <= 0;
            m <= m + 1'b1;
        end
        else if (m == 6'b111100) begin
            m <= 0;
            h <= h +1'b1;
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
