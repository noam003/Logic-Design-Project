`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/07/2022 03:52:54 PM
// Design Name: 
// Module Name: display
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


module display_blue(
    input [7:0] hours,
    input [7:0] min,
    input [7:0] sec,
    input [7:0] ms,
    input clk,
    input reset,
    output wire VGA_HS,       // horizontal sync output
    output wire VGA_VS,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B     // 4-bit VGA blue output
    );
    
    wire rst = reset;    // reset is active low on Arty & Nexys Video
    
    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
    always @(posedge clk)
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511

    vga640x480 display (
        .i_clk(clk),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS), 
        .o_vs(VGA_VS), 
        .o_x(x), 
        .o_y(y)
    );

    // Wires to hold regions on FPGA
	
	// H is representative of regions that are for hours
	wire H1a, H1b, H1c, H1d, H1e, H1f, H1g;
    wire H2a, H2b, H2c, H2d, H2e, H2f, H2g;
    
    // M is representative of regions that are for minutes
	wire M1a, M1b, M1c, M1d, M1e, M1f, M1g;
    wire M2a, M2b, M2c, M2d, M2e, M2f, M2g;
    
    // S is representative of regions that are for seconds
	wire S1a, S1b, S1c, S1d, S1e, S1f, S1g;
    wire S2a, S2b, S2c, S2d, S2e, S2f, S2g;
    
    // MS is representative of regions that are for milliseconds
	wire MS1a, MS1b, MS1c, MS1d, MS1e, MS1f, MS1g;
    wire MS2a, MS2b, MS2c, MS2d, MS2e, MS2f, MS2g;
    
    // C represents the colons and the periods needed for the display
    wire C1, C2, C3, C4, C5;
    
    wire disp;
    
    //Registers for entities
	reg segments;
	
	// Creating Regions on the VGA Display represented as wires (640x480)
	
	assign disp = ((x > 95) & (y > 205) & (x < 535) & (y < 275)) ? 1 : 0;
	
	// H1 is representative of the first digit of the hour, and the letters a-g correspond the the 7-segments of the 7-segment display
	assign H1d = ((x > 105) & (y > 265) & (x < 125) & (y < 275)) ? 1 : 0;
	assign H1c = ((x > 125) & (y > 245) & (x < 135) & (y < 265)) ? 1 : 0;
	assign H1b = ((x > 125) & (y > 215) & (x < 135) & (y < 235)) ? 1 : 0;
	assign H1a = ((x > 105) & (y > 205) & (x < 125) & (y < 215)) ? 1 : 0;
	assign H1f = ((x > 95) & (y > 215) & (x < 105) & (y < 235)) ? 1 : 0;
	assign H1e = ((x > 95) & (y > 245) & (x < 105) & (y < 265)) ? 1 : 0;
	assign H1g = ((x > 105) & (y > 235) & (x < 125) & (y < 245)) ? 1 : 0;
	
	// H2 is representative of the second digit of the hour, and the letters a-g correspond the the 7-segments of the 7-segment display
	assign H2d = ((x > 155) & (y > 265) & (x < 175) & (y < 275)) ? 1 : 0;
	assign H2c = ((x > 175) & (y > 245) & (x < 185) & (y < 265)) ? 1 : 0;
	assign H2b = ((x > 175) & (y > 215) & (x < 185) & (y < 235)) ? 1 : 0;
	assign H2a = ((x > 155) & (y > 205) & (x < 175) & (y < 215)) ? 1 : 0;
	assign H2f = ((x > 145) & (y > 215) & (x < 155) & (y < 235)) ? 1 : 0;
	assign H2e = ((x > 145) & (y > 245) & (x < 155) & (y < 265)) ? 1 : 0;
	assign H2g = ((x > 155) & (y > 235) & (x < 175) & (y < 245)) ? 1 : 0;
	
	// M1 is representative of the first digit of the minutes, and the letters a-g correspond the the 7-segments of the 7-segment display
	assign M1d = ((x > 225) & (y > 265) & (x < 245) & (y < 275)) ? 1 : 0;
	assign M1c = ((x > 245) & (y > 245) & (x < 255) & (y < 265)) ? 1 : 0;
	assign M1b = ((x > 245) & (y > 215) & (x < 255) & (y < 235)) ? 1 : 0;
	assign M1a = ((x > 225) & (y > 205) & (x < 245) & (y < 215)) ? 1 : 0;
	assign M1f = ((x > 215) & (y > 215) & (x < 225) & (y < 235)) ? 1 : 0;
	assign M1e = ((x > 215) & (y > 245) & (x < 225) & (y < 265)) ? 1 : 0;
	assign M1g = ((x > 225) & (y > 235) & (x < 245) & (y < 245)) ? 1 : 0;
	
	// M2 is representative of the second digit of the minutes, and the letters a-g correspond the the 7-segments of the 7-segment display
	assign M2d = ((x > 275) & (y > 265) & (x < 295) & (y < 275)) ? 1 : 0;
	assign M2c = ((x > 295) & (y > 245) & (x < 305) & (y < 265)) ? 1 : 0;
	assign M2b = ((x > 295) & (y > 215) & (x < 305) & (y < 235)) ? 1 : 0;
	assign M2a = ((x > 275) & (y > 205) & (x < 295) & (y < 215)) ? 1 : 0;
	assign M2f = ((x > 265) & (y > 215) & (x < 275) & (y < 235)) ? 1 : 0;
	assign M2e = ((x > 265) & (y > 245) & (x < 275) & (y < 265)) ? 1 : 0;
	assign M2g = ((x > 275) & (y > 235) & (x < 295) & (y < 245)) ? 1 : 0;
	
	// S1 is representative of the first digit of the seconds, and the letters a-g correspond the the 7-segments of the 7-segment display
	assign S1d = ((x > 345) & (y > 265) & (x < 365) & (y < 275)) ? 1 : 0;
	assign S1c = ((x > 365) & (y > 245) & (x < 375) & (y < 265)) ? 1 : 0;
	assign S1b = ((x > 365) & (y > 215) & (x < 375) & (y < 235)) ? 1 : 0;
	assign S1a = ((x > 345) & (y > 205) & (x < 365) & (y < 215)) ? 1 : 0;
	assign S1f = ((x > 335) & (y > 215) & (x < 345) & (y < 235)) ? 1 : 0;
	assign S1e = ((x > 335) & (y > 245) & (x < 345) & (y < 265)) ? 1 : 0;
	assign S1g = ((x > 345) & (y > 235) & (x < 365) & (y < 245)) ? 1 : 0;
	
	// S2 is representative of the second digit of the seconds, and the letters a-g correspond the the 7-segments of the 7-segment display
	assign S2d = ((x > 395) & (y > 265) & (x < 415) & (y < 275)) ? 1 : 0;
	assign S2c = ((x > 415) & (y > 245) & (x < 425) & (y < 265)) ? 1 : 0;
	assign S2b = ((x > 415) & (y > 215) & (x < 425) & (y < 235)) ? 1 : 0;
	assign S2a = ((x > 395) & (y > 205) & (x < 415) & (y < 215)) ? 1 : 0;
	assign S2f = ((x > 385) & (y > 215) & (x < 395) & (y < 235)) ? 1 : 0;
	assign S2e = ((x > 385) & (y > 245) & (x < 395) & (y < 265)) ? 1 : 0;
	assign S2g = ((x > 395) & (y > 235) & (x < 415) & (y < 245)) ? 1 : 0;
	
	// MS1 is representative of the first digit of the milliseconds, and the letters a-g correspond the the 7-segments of the 7-segment display
	assign MS1d = ((x > 465) & (y > 265) & (x < 485) & (y < 275)) ? 1 : 0;
	assign MS1c = ((x > 485) & (y > 245) & (x < 495) & (y < 265)) ? 1 : 0;
	assign MS1b = ((x > 485) & (y > 215) & (x < 495) & (y < 235)) ? 1 : 0;
	assign MS1a = ((x > 465) & (y > 205) & (x < 485) & (y < 215)) ? 1 : 0;
	assign MS1f = ((x > 455) & (y > 215) & (x < 465) & (y < 235)) ? 1 : 0;
	assign MS1e = ((x > 455) & (y > 245) & (x < 465) & (y < 265)) ? 1 : 0;
	assign MS1g = ((x > 465) & (y > 235) & (x < 485) & (y < 245)) ? 1 : 0;
	
	// MS2 is representative of the second digit of the milliseconds, and the letters a-g correspond the the 7-segments of the 7-segment display
	assign MS2d = ((x > 515) & (y > 265) & (x < 535) & (y < 275)) ? 1 : 0;
	assign MS2c = ((x > 535) & (y > 245) & (x < 545) & (y < 265)) ? 1 : 0;
	assign MS2b = ((x > 535) & (y > 215) & (x < 545) & (y < 235)) ? 1 : 0;
	assign MS2a = ((x > 515) & (y > 205) & (x < 535) & (y < 215)) ? 1 : 0;
	assign MS2f = ((x > 505) & (y > 215) & (x < 515) & (y < 235)) ? 1 : 0;
	assign MS2e = ((x > 505) & (y > 245) & (x < 515) & (y < 265)) ? 1 : 0;
	assign MS2g = ((x > 515) & (y > 235) & (x < 535) & (y < 245)) ? 1 : 0;
	
	// C1-5 is representative of the colons and periods needed on the display
	assign C1 = ((x > 195) & (y > 215) & (x < 205) & (y < 225)) ? 1 : 0;
	assign C2 = ((x > 195) & (y > 245) & (x < 205) & (y < 255)) ? 1 : 0;
	assign C3 = ((x > 315) & (y > 215) & (x < 325) & (y < 225)) ? 1 : 0;
	assign C4 = ((x > 315) & (y > 245) & (x < 325) & (y < 255)) ? 1 : 0;
	assign C5 = ((x > 435) & (y > 265) & (x < 445) & (y < 275)) ? 1 : 0;

 // Assign the registers to the VGA 3rd output. This will display strong red on the Screen when 
 // grid = 1, and strong green on the screen when green = 1;
    assign VGA_R[3] = 0;
    assign VGA_G[3] = 0;
    assign VGA_B[3] = segments; 
 
    always @ (*) begin 
        segments =  H1a + H1b + H1c + H1d + H1e + H1f + H1g + H2a + H2b + H2c + H2d + H2e + H2f + H2g + M1a + M1b + M1c + M1d + M1e + M1f + M1g + M2a + M2b + M2c + M2d + M2e + M2f + M2g + S1a + S1b + S1c + S1d + S1e + S1f + S1g + S2a + S2b + S2c + S2d + S2e + S2f + S2g + MS1a + MS1b + MS1c + MS1d + MS1e + MS1f + MS1g + MS2a + MS2b + MS2c + MS2d + MS2e + MS2f + MS2g + C1 + C2 + C3 + C4 + C5;
        //segments = H1a + H2a + M1a + M2a + S1a + S2a + MS1a + MS2a + H1g + C5; 
        
        // If we want to display 0
        if (hours[7:4] == 4'b0000) begin
            segments = segments - (H1a + H1b + H1c + H1d + H1e + H1f + H1g);
        end
        if (hours[3:0] == 4'b0000) begin
            segments = segments - (H2g);
        end
        if (min[7:4] == 4'b0000) begin
            segments = segments - (M1g);
        end
        if (min[3:0] == 4'b0000) begin
            segments = segments - (M2g);
        end
        if (sec[7:4] == 4'b0000) begin
            segments = segments - (S1g);
        end
        if (sec[3:0] == 4'b0000) begin
            segments = segments - (S2g);
        end
        if (ms[7:4] == 4'b0000) begin
            segments = segments - (MS1g);
        end
        if (ms[3:0] == 4'b0000) begin
            segments = segments - (MS2g);
        end
        
        // If we want to display a 1
        if (hours[7:4] == 4'b0001) begin
            segments = segments - (H1a + H1d + H1e + H1f + H1g);
        end
        if (hours[3:0] == 4'b0001) begin
            segments = segments - (H2a + H2d + H2e + H2f + H2g);
        end
        if (min[7:4] == 4'b0001) begin
            segments = segments - (M1a + M1d + M1e + M1f + M1g);
        end
        if (min[3:0] == 4'b0001) begin
            segments = segments - (M2a + M2d + M2e + M2f + M2g);
        end
        if (sec[7:4] == 4'b0001) begin
            segments = segments - (S1a + S1d + S1e + S1f + S1g);
        end
        if (sec[3:0] == 4'b0001) begin
            segments = segments - (S2a + S2d + S2e + S2f + S2g);
        end
        if (ms[7:4] == 4'b0001) begin
            segments = segments - (MS1a + MS1d + MS1e + MS1f + MS1g);
        end
        if (ms[3:0] == 4'b0001) begin
            segments = segments - (MS2a + MS2d + MS2e + MS2f + MS2g);
        end
        
        // If we want to display a 2
        if (hours[7:4] == 4'b0010) begin
            segments = segments - (H1c + H1f);
        end
        if (hours[3:0] == 4'b0010) begin
            segments = segments - (H2c + H2f);
        end
        if (min[7:4] == 4'b0010) begin
            segments = segments - (M1c + M1f);
        end
        if (min[3:0] == 4'b0010) begin
            segments = segments - (M2c + M2f);
        end
        if (sec[7:4] == 4'b0010) begin
            segments = segments - (S1c + S1f);
        end
        if (sec[3:0] == 4'b0010) begin
            segments = segments - (S2c + S2f);
        end
        if (ms[7:4] == 4'b0010) begin
            segments = segments - (MS1c + MS1f);
        end
        if (ms[3:0] == 4'b0010) begin
            segments = segments - (MS2c + MS2f);
        end
        
        // If we want to display a 3
        if (hours[7:4] == 4'b0011) begin
            segments = segments - (H1e + H1f);
        end
        if (hours[3:0] == 4'b0011) begin
            segments = segments - (H2e + H2f);
        end
        if (min[7:4] == 4'b0011) begin
            segments = segments - (M1e + M1f);
        end
        if (min[3:0] == 4'b0011) begin
            segments = segments - (M2e + M2f);
        end
        if (sec[7:4] == 4'b0011) begin
            segments = segments - (S1e + S1f);
        end
        if (sec[3:0] == 4'b0011) begin
            segments = segments - (S2e + S2f);
        end
        if (ms[7:4] == 4'b0011) begin
            segments = segments - (MS1e + MS1f);
        end
        if (ms[3:0] == 4'b0011) begin
            segments = segments - (MS2e + MS2f);
        end
        
        // If we want to display a 4
        if (hours[7:4] == 4'b0100) begin
            segments = segments - (H1a + H1d + H1e);
        end
        if (hours[3:0] == 4'b0100) begin
            segments = segments - (H2a +  H2d + H2e);
        end
        if (min[7:4] == 4'b0100) begin
            segments = segments - (M1a +  M1d + M1e);
        end
        if (min[3:0] == 4'b0100) begin
            segments = segments - (M2a + M2d + M2e);
        end
        if (sec[7:4] == 4'b0100) begin
            segments = segments - (S1a + S1d + S1e);
        end
        if (sec[3:0] == 4'b0100) begin
            segments = segments - (S2a + S2d + S2e);
        end
        if (ms[7:4] == 4'b0100) begin
            segments = segments - (MS1a + MS1d + MS1e);
        end
        if (ms[3:0] == 4'b0100) begin
            segments = segments - (MS2a + MS2d + MS2e);
        end
        
        // If we want to display a 5
        if (hours[7:4] == 4'b0101) begin
            segments = segments - (H1b + H1e);
        end
        if (hours[3:0] == 4'b0101) begin
            segments = segments - (H2b + H2e);
        end
        if (min[7:4] == 4'b0101) begin
            segments = segments - (M1b + M1e);
        end
        if (min[3:0] == 4'b0101) begin
            segments = segments - (M2b + M2e);
        end
        if (sec[7:4] == 4'b0101) begin
            segments = segments - (S1b + S1e);
        end
        if (sec[3:0] == 4'b0101) begin
            segments = segments - (S2b + S2e);
        end
        if (ms[7:4] == 4'b0101) begin
            segments = segments - (MS1b + MS1e);
        end
        if (ms[3:0] == 4'b0101) begin
            segments = segments - (MS2b + MS2e);
        end
        
        // If we want to display a 6
        if (hours[7:4] == 4'b0110) begin
            segments = segments - (H1b);
        end
        if (hours[3:0] == 4'b0110) begin
            segments = segments - (H2b);
        end
        if (min[7:4] == 4'b0110) begin
            segments = segments - (M1b);
        end
        if (min[3:0] == 4'b0110) begin
            segments = segments - (M2b);
        end
        if (sec[7:4] == 4'b0110) begin
            segments = segments - (S1b);
        end
        if (sec[3:0] == 4'b0110) begin
            segments = segments - (S2b);
        end
        if (ms[7:4] == 4'b0110) begin
            segments = segments - (MS1b);
        end
        if (ms[3:0] == 4'b0110) begin
            segments = segments - (MS2b);
        end
        
        // If we want to display a 7
        if (hours[7:4] == 4'b0111) begin
            segments = segments - (H1d + H1e + H1f + H1g);
        end
        if (hours[3:0] == 4'b0111) begin
            segments = segments - (H2d + H2e + H2f + H2g);
        end
        if (min[7:4] == 4'b0111) begin
            segments = segments - (M1d + M1e + M1f + M1g);
        end
        if (min[3:0] == 4'b0111) begin
            segments = segments - (M2d + M2e + M2f + M2g);
        end
        if (sec[7:4] == 4'b0111) begin
            segments = segments - (S1d + S1e + S1f + S1g);
        end
        if (sec[3:0] == 4'b0111) begin
            segments = segments - (S2d + S2e + S2f + S2g);
        end
        if (ms[7:4] == 4'b0111) begin
            segments = segments - (MS1d + MS1e + MS1f + MS1g);
        end
        if (ms[3:0] == 4'b0111) begin
            segments = segments - (MS2d + MS2e + MS2f + MS2g);
        end
        
        // If we want to display a 8
        if (hours[7:4] == 4'b1000) begin
            segments = segments;
        end
        if (hours[3:0] == 4'b1000) begin
            segments = segments;
        end
        if (min[7:4] == 4'b1000) begin
            segments = segments;
        end
        if (min[3:0] == 4'b1000) begin
            segments = segments;
        end
        if (sec[7:4] == 4'b1000) begin
            segments = segments;
        end
        if (sec[3:0] == 4'b1000) begin
            segments = segments;
        end
        if (ms[7:4] == 4'b1000) begin
            segments = segments;
        end
        if (ms[3:0] == 4'b1000) begin
            segments = segments;
        end
        
        // If we want to display a 9
        if (hours[7:4] == 4'b1001) begin
            segments = segments - (H1e);
        end
        if (hours[3:0] == 4'b1001) begin
            segments = segments - (H2e);
        end
        if (min[7:4] == 4'b1001) begin
            segments = segments - (M1e);
        end
        if (min[3:0] == 4'b1001) begin
            segments = segments - (M2e);
        end
        if (sec[7:4] == 4'b1001) begin
            segments = segments - (S1e);
        end
        if (sec[3:0] == 4'b1001) begin
            segments = segments - (S2e);
        end
        if (ms[7:4] == 4'b1001) begin
            segments = segments - (MS1e);
        end
        if (ms[3:0] == 4'b1001) begin
            segments = segments - (MS2e);
        end
        
    end

endmodule
