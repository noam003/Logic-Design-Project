`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 12:23:51 PM
// Design Name: 
// Module Name: mux_4to1
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


module mux_4to1(in1, in2, in3, in4, select, mux_out);
    input [26:0] in1, in2, in3, in4;
    input [1:0] select;
    output reg [26:0] mux_out;
        
    always @ (*) begin
        case (select)
            2'b00: mux_out <= in1;
            2'b01: mux_out <= in2;
            2'b10: mux_out <= in3;
            2'b11: mux_out <= in4;
        endcase
    end //always  
    
endmodule
