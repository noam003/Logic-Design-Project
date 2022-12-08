`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/08/2022 04:38:55 PM
// Design Name: 
// Module Name: tb_binary_to_bcd
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


module tb_binary_to_bcd;

    // Input
    reg [7:0] bin;
    // Output
    wire [11:0] bcd;
    // Extra variables
    reg [8:0] i;

    // Instantiate the Unit Under Test (UUT)
    binary_to_bcd bcdTest (
        .bin(bin), 
        .bcd(bcd)
    );

//Simulation - Apply inputs
    initial begin
    //A for loop for checking all the input combinations.
        for(i=0;i<256;i=i+1)
        begin
            bin = i; 
            #10; //wait for 10 ns.
        end 
        $finish; //system function for stoping the simulation.
    end
      
endmodule
