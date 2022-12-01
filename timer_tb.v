`timescale 1ns / 1ps

// Last Modified by Laura 12/1/2021
module timer_tb();

    reg clk, reset, toggle;
    wire [23:0] disp_time;
    
    timer T0 (.clk(clk), .reset(reset), .toggle(toggle), .disp_time(disp_time));
    
    initial begin
        clk = 0;
        reset = 1;
        toggle = 1;
    end
    
    always #10 reset = 0;
    always #0.001 clk = ~clk;
    always #500 toggle = 0;
    always #900 reset = 1;
    
    always #3000 $stop;
endmodule
