`timescale 1ns / 1ps

// Engineer: Noa Margolin 
// Module Name: tb_clock24

module tb_clock24();
    reg clk;
    reg reset;
    wire [23:0] disp_time;
    
    clock_24hr digital_clock24(.kh_clk(clk), .reset(reset), .disp_time(disp_time));
    
    initial begin 
        clk = 0;
    end

    always #1 clk = ~clk;
    
    initial begin
        reset = 1;
        #3 reset = 0;
    end
endmodule
