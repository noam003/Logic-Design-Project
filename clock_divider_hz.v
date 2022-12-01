`timescale 1ns / 1ps

module clock_divider_hz(clk_i, clk_o, resetn);

    input clk_i, resetn;
    output reg clk_o = 0;
    reg [31:0] count;
    
    always @ (posedge clk_i) begin
       if (count == 50000000-1) begin
            count <= 0;
            clk_o <= ~clk_o;
        end else begin
            count <= count + 1'b1;
            clk_o <= clk_o;
        end
    end
    
endmodule

