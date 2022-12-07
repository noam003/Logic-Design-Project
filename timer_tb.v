`timescale 1 ns / 1ps

// Last Modified by Laura 12/7/2021
module timer_tb();

    reg clk, reset, toggle;
    wire [26:0] out_time;
    
    timer T0 (.clk(clk), .reset(reset), .toggle(toggle), .out_time(out_time));
    
    initial begin
        clk = 0;
        reset = 1;
        toggle = 1;
        #10000 $stop;
    end
    
    always #10 reset = 0;
    always #0.001 clk = ~clk;
    always #900 reset = 1;
    
endmodule
