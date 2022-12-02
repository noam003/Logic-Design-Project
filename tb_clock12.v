`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Engineer: Noa Margolin
// Description: Test bench for 12 hour clock


module tb_clock12( );

    reg clk;
    reg reset;
    wire [23:0] disp_time;
    
    clock_12hr digital_clock12(.kh_clk(clk), .reset(reset), .disp_time(disp_time));
    
    initial begin 
        clk = 0;
    end

    always #1 clk = ~clk;
    
    initial begin
        reset = 1;
        #3 reset = 0;
    end
endmodule
