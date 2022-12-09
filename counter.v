`timescale 1ns / 1ps

module counter(select_in, reset, count);
    input reset, select_in; // enable determines if incrementer
    output reg [1:0] count;
    initial begin
        count = 0;
    end 
                         
    always @ (posedge select_in or posedge reset) begin
        if (!reset) begin
            count <= 0;
        end else begin
            if (select_in == 1) begin
                count <= count + 1'b1;
            end
        end
    end
endmodule