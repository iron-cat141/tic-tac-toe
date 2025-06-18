module TCell(input clk, set, reset, set_symbol, output reg valid, output reg symbol);
    initial begin
        valid = 0;
    end

    always @(posedge clk) begin
        if(reset == 1'b1) begin
            valid = 1'b0;
        end else begin
            if( set == 1'b1 && valid == 1'b0 ) begin
                    symbol = set_symbol;
                    valid = 1'b1;
                end
            end

    end

endmodule