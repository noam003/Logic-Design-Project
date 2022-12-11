`timescale 1ns / 1ps

module count_out(button_in, button_type, count_in, clk, ms_sw, s_sw, min_sw, hr_sw, reset, out);
    input reset, clk, ms_sw, s_sw, min_sw, hr_sw, button_in, count_in;
    input [1:0] button_type;
    output reg [26:0] out;   
                                   
    always @ (posedge clk) begin

        if (reset || count_in == 0)
            out = 0;
        else if (button_type == 2'b01 && button_in) begin
            out = out + 1'b1;
        end else if (button_type == 2'b10 && button_in) begin
            out = out + 4'b1010;
        end else
            out = 0;
            
        if (ms_sw && out > 10'b1111101000)
            out = out - 10'b1111101000;
        else if ((s_sw || min_sw || hr_sw) && out > 6'b111011)
            out = out - 6'b111011;
            
    end
    
    
endmodule
