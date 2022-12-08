module debouncer(
    input clk,
    input resetn,
    input button_in_one,
    input button_in_ten,
    input toggle,
    output reg button_out,
    output reg [1:0] button_type
    );
    
    reg output_exist;
    reg [19:0] deb_count;
    
    parameter MAX = 100;
    reg max_count_flag;
    
    always @ (posedge clk) begin
        if (!resetn) begin
            deb_count <= 0;
            output_exist <= 0; 
            button_out <= 0;
        end else begin 
            if (!toggle && (button_in_one || button_in_ten)) begin
                deb_count <= deb_count + 1;
                
                
             
                if ((deb_count == MAX) && (max_count_flag == 0)) begin
                    button_out <= 1'b1;
                    deb_count <= deb_count; 
                    output_exist <= 1;
                    max_count_flag <= 1;
                    
                    if (button_in_one)
                        button_type <= 2'b01;
                    if (button_in_ten)
                        button_type <= 2'b10;
                end
                
                if (output_exist) begin
                    button_out <= 1'b0;
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
