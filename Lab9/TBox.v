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

module row_col_decoder (
    input [1:0] row,
    input [1:0] col,
    output [8:0] out
);
    wire [3:0] out_row,out_col;
    wire [1:0] row_n;
    wire [1:0] col_n;

    assign col_n = ~col;
    assign row_n = ~row;

    and(out_row[3],row[1],row[0]);
    and(out_row[2],row[1],row_n[0]);
    and(out_row[1],row_n[1],row[0]);
    and(out_row[0],row_n[1],row_n[0]);

    and(out_col[3],col[1],col[0]);
    and(out_col[2],col[1],col_n[0]);
    and(out_col[1],col_n[1],col[0]);
    and(out_col[0],col_n[1],col_n[0]);

    and(out[8],out_row[1],out_col[1]);
    and(out[7],out_row[1],out_col[2]);
    and(out[6],out_row[1],out_col[3]);
    and(out[5],out_row[2],out_col[1]);
    and(out[4],out_row[2],out_col[2]);
    and(out[3],out_row[2],out_col[3]);
    and(out[2],out_row[3],out_col[1]);
    and(out[1],out_row[3],out_col[2]);
    and(out[0],out_row[3],out_col[3]);
    

    
endmodule

module TBox(input clk, set, reset, input [1:0] row, input [1:0] col,output [8:0] valid, output [8:0] symbol, output reg [1:0] game_state);

    reg curr_symbol;

    wire [8:0] idx;
    wire [8:0] setter;

    row_col_decoder hello(.row(row),.col(col),.out(idx));
    
    and(setter[8],set,idx[8],~game_state[1],~game_state[0]);
    and(setter[7],set,idx[7],~game_state[1],~game_state[0]);
    and(setter[6],set,idx[6],~game_state[1],~game_state[0]);
    and(setter[5],set,idx[5],~game_state[1],~game_state[0]);
    and(setter[4],set,idx[4],~game_state[1],~game_state[0]);
    and(setter[3],set,idx[3],~game_state[1],~game_state[0]);
    and(setter[2],set,idx[2],~game_state[1],~game_state[0]);
    and(setter[1],set,idx[1],~game_state[1],~game_state[0]);
    and(setter[0],set,idx[0],~game_state[1],~game_state[0]);

    TCell kid(.clk(clk), .set(setter[8]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[8]), .symbol(symbol[8]));
    TCell son(.clk(clk), .set(setter[7]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[7]), .symbol(symbol[7]));
    TCell dog(.clk(clk), .set(setter[6]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[6]), .symbol(symbol[6]));
    TCell nep(.clk(clk), .set(setter[5]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[5]), .symbol(symbol[5]));
    TCell sis(.clk(clk), .set(setter[4]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[4]), .symbol(symbol[4]));
    TCell bro(.clk(clk), .set(setter[3]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[3]), .symbol(symbol[3]));
    TCell dad(.clk(clk), .set(setter[2]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[2]), .symbol(symbol[2]));
    TCell pop(.clk(clk), .set(setter[1]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[1]), .symbol(symbol[1]));
    TCell mom(.clk(clk), .set(setter[0]), .reset(reset), .set_symbol(curr_symbol), .valid(valid[0]), .symbol(symbol[0]));

    always @(posedge clk) begin
        // counter <= ~(valid[0] ^ valid[1] ^ valid[2] ^ valid[3] ^ valid[4] ^ valid[5] ^ valid[6] ^ valid[7] ^ valid[8]) ;
        curr_symbol <= ~( ^valid );
        if(reset == 1'b1) begin
            game_state <= 2'b00;
        end
        else if (game_state == 2'b00) begin
            if ( ~(valid[0] & valid[1] & valid[2] & valid[3] & valid[4] & valid[5] & valid[6] & valid[7] & valid[8]) ) begin
                
                if( (valid[8] & valid[5] & valid[2]) && symbol[8] == symbol[5] && symbol[8] == symbol[2]) game_state <= {~curr_symbol,curr_symbol}; else
                if( (valid[7] & valid[4] & valid[1]) && symbol[7] == symbol[4] && symbol[7] == symbol[1]) game_state <= {~curr_symbol,curr_symbol}; else
                if( (valid[6] & valid[3] & valid[0]) && symbol[6] == symbol[3] && symbol[6] == symbol[0]) game_state <= {~curr_symbol,curr_symbol}; else
                if( (valid[8] & valid[7] & valid[6]) && symbol[8] == symbol[7] && symbol[8] == symbol[6]) game_state <= {~curr_symbol,curr_symbol}; else
                if( (valid[5] & valid[4] & valid[3]) && symbol[5] == symbol[4] && symbol[5] == symbol[3]) game_state <= {~curr_symbol,curr_symbol}; else
                if( (valid[2] & valid[1] & valid[0]) && symbol[2] == symbol[1] && symbol[2] == symbol[0]) game_state <= {~curr_symbol,curr_symbol}; else
                if( (valid[8] & valid[4] & valid[0]) && symbol[8] == symbol[4] && symbol[8] == symbol[0]) game_state <= {~curr_symbol,curr_symbol}; else
                if( (valid[6] & valid[4] & valid[2]) && symbol[6] == symbol[4] && symbol[6] == symbol[2]) game_state <= {~curr_symbol,curr_symbol};
                // else game_state <= 2'b00;
            end
        end



    end


endmodule