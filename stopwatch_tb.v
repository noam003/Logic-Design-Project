`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2022 03:57:02 PM
// Design Name: 
// Module Name: stopwatch_tb
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

//Verilog Stopwatch Testbench
module stopwatch_tb;
    
    reg clk, reset, toggle;
    wire [23:0] disp_time;
    
    stopwatch S0(.clk(clk), .reset(reset), .toggle(toggle), .disp_time(disp_time));
    
    initial begin
        clk <= 0;
        reset <= 1;
        toggle <= 1;
    end
    
    always #0.5 reset = 0;
    always #1 clk = ~clk;
    always #100 toggle = ~toggle;
    always #900 reset = 1;
    
    always #1000 $stop;
    
endmodule
