`timescale 1ns / 1ps

module count_out(button_in, button_type, clk, ms_sw, s_sw, min_sw, hr_sw, reset, out);
    input reset, clk, ms_sw, s_sw, min_sw, hr_sw, button_in;
    input [1:0] button_type;
    output reg [26:0] out;
    
    always @ (posedge clk or posedge reset) begin
        if (reset)
            out = 0;
        else if (button_type == 2'b01 && button_in)
            out = out + 1'b1;
        else if (button_type == 2'b10 && button_in)
            out = out + 4'b1010;
        else
            out = 0;
            
        if (ms_sw && out > 10'b1111101000)
            out = out - 10'b1111101000;
        else if ((s_sw || min_sw || hr_sw) && out > 6'b111011)
            out = out - 6'b111011;
    end
    
    always @ (posedge ms_sw or posedge s_sw or posedge min_sw or posedge hr_sw) begin
        out = 0;
    end
endmodule
