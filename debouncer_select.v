`timescale 1ns / 1ps

module debouncer_select(clock,reset, button_in, button_out);
    input clock, reset, button_in;
    output reg button_out;
    reg output_exists;
    // reg [1:0] cs, ns;
    parameter s0 = 1'b0, s1=1'b1; 
    
    parameter MAX=50000; // random number
    integer deb_count;
    initial begin
        deb_count = 0;
        output_exists = 1'b0;
        button_out = 1'b0;
    end
    always @ (posedge clock, posedge reset) begin
        if (!reset) begin
           deb_count <= 0;
            output_exists <= 1'b0;
            button_out <= 1'b0;
        end else begin
            if (button_in == 1'b1) begin
                if (output_exists == 0) begin
                    deb_count <= deb_count + 1;
                    if (deb_count == MAX) begin
                        button_out <= 1;
                        deb_count <= 0;
                        output_exists <= 1;
                     end
                 end else begin
                    button_out <= 1'b0;
                    
                 end
            end else begin
                deb_count <= 0;
                output_exists <= 1'b0;
                button_out <= 1'b0;
            end
        end
    end
endmodule

