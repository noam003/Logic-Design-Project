`timescale 1ns / 1ps
// clock changes every ms
module clock_divider_khz(clk_i, clk_o, resetn);

    input clk_i, resetn;
    output reg clk_o = 0;
    reg [31:0] count = 0;
    
    always @ (posedge clk_i) begin
        if (count == 49999) begin
            count <= 0;
            clk_o <= ~clk_o;
        end else begin
            count <= count + 1'b1;
            clk_o <= clk_o;
        end
    end
    
endmodule
