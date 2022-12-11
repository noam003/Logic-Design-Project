`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 05:59:46 PM
// Design Name: 
// Module Name: twelve_converter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module twelve_converter(input [26:0] time_in,
    input clk,
    output reg [26:0] time_out
    );
    
    always @ (posedge clk) begin
        if (time_in[26:22] == 5'b00000) begin
            time_out[25:22] <= 5'b01100;
            time_out[21:0] <= time_in[21:0];
        end else begin
            time_out <= time_in;
        end
    end
    
    
endmodule
