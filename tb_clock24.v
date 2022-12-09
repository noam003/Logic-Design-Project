`timescale 1ns / 1ps

// Engineer: Noa Margolin 
// Module Name: tb_clock24

module tb_clock24();
    reg clk;
    reg spring_szn;
    reg reset;
    wire [23:0] disp_time;
    
    clock_24hr digital_clock24(.kh_clk(clk), .spring_szn(spring_szn), .reset(reset), .disp_time(disp_time));
    
    initial begin 
        clk = 0;
        spring_szn = 0;
    end

    always #1 clk = ~clk;
    
    initial begin
        reset = 1;
        #3 reset = 0;
        #5000 spring_szn = ~spring_szn;
        #6000 spring_szn = ~spring_szn;
    end
endmodule
