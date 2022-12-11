module debouncer(
    input clk,
    input reset,
    input button_in,
    output reg button_out
    );
    
    reg output_exist;
    reg [19:0] deb_count;
    
    parameter MAX = 100;
    reg max_count_flag;
    
    always @ (posedge clk) begin
        if (reset) begin
            deb_count <= 0;
            output_exist <= 0; 
            button_out <= 0;
            max_count_flag <= 0;
        end else begin 
            if (button_in) begin
                deb_count <= deb_count + 1;

                if ((deb_count == MAX) && (max_count_flag == 0)) begin
                    button_out <= 1'b1;
                    deb_count <= 0; 
                    output_exist <= 1;
                    max_count_flag <= 0;   
                end
                
                if (output_exist) begin
                    button_out <= 1'b0;
                    output_exist <= 0;
                end 
            
            end else if (!button_in) begin
                deb_count <= 0;
                button_out <= 0;
                output_exist <= 0; 
                max_count_flag <= 0;
            end 
        end 
        
    end // always
 
endmodule
