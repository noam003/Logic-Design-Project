`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

// Engineer: Noa Margolin
// Description: Test bench for 12 hour clock


module tb_clock12( );

    reg clk;
    reg spring_szn;
    reg reset;
    wire [26:0] disp_time;
    
    clock_12hr digital_clock12(.kh_clk(clk), .spring_szn(spring_szn), .reset(reset), .disp_time(disp_time));
    
    initial begin 
        clk = 0;
        spring_szn = 1;
        reset = 0;
    end

    always #1 clk = ~clk;
    always #20 spring_szn = ~spring_szn;
    

endmodule
