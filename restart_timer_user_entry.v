`timescale 1ns / 1ps


module restart_timer_user_entry(count_in, count_out);
    input [3:0] count_in;
    output reg count_out;
    
    always @ (*) begin
        if (count_in == 0)     
            count_out = 0;
        else
            count_out = 1;
    end
            
endmodule
