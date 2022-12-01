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
    output reg [7:0] disp_time;
    
    //toggle value: 0 = stop, 1 = start
    
    reg [1:0] h, m, s, ms;
    
    always @ (posedge clk or posedge reset) begin
        if (reset)
            disp_time <= 0;
        else begin
            if (toggle)
                ms <= ms +1'b1;
        end
    end
    
    always @ (*) begin
        if (ms == 2'd59) begin
            ms <= 0;
            s <= s + 'b1;
        end
        else if (s == 2'd59) begin
            s <= 0;
            m <= m + 1'b1;
        end
        else if (m == 2'd59) begin
            m <= 0;
            h <= h +1'b1;
        end
        else if (h == 2'd24) begin       //reset everything, max value
            ms <= 0;
            s <= 0;
            m <= 0;
            h <= 0;
        end
        
        disp_time <= {h,m,s,ms};
            
    end
    
    
endmodule
