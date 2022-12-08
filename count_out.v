`timescale 1ns / 1ps

module count_out(button_in, out);
    input [1:0] button_in;
    output reg [26:0] out;
    
    always @ (*) begin
        if (button_in == 2'b01)
            out <= out + 1'b1;
        else if (button_in == 2'b10)
            out <= out + 4'b1010;
    end
endmodule
