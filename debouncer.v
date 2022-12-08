module debouncer(
    input clk,
    input resetn,
    input button_in_one,
    input button_in_ten,
    output reg [7:0] button_out
    );
    
    reg output_exist;
    reg [19:0] deb_count;
    reg [26:0] out_count;
    
    parameter MAX = 100;
    reg max_count_flag;
    
    always @ (posedge clk) begin
        if (!resetn) begin
            deb_count <= 0;
            output_exist <= 0; 
            button_out <= 0;
        end else begin 
            if (button_in_one || button_in_ten) begin
                deb_count <= deb_count + 1;
                
                if (button_in_one)
                    out_count <= out_count + 1'b1;
                if (button_in_ten)
                    out_count <= out_count + 4'b1010;
             
                if ((deb_count == MAX) && (max_count_flag == 0)) begin
                    button_out <= 1;
                    deb_count <= deb_count; 
                    output_exist <= 1;
                    max_count_flag <= 1;
                end
                
                if (output_exist) begin
                    button_out <= out_count;
                    output_exist <= 0;
                end 
            
            end else if (!button_in_one || !button_in_ten) begin
                deb_count <= 0;
                button_out <= 0;
                output_exist <= 0; 
                max_count_flag <= 0;
            end 
        end 
        
    end // always
 
endmodule