module D_a(input d, input en, input rstn, output reg q);
    always @(*) begin
        if(rstn == 1'b0) q = 0;
        else if(en) q = d;
    end
endmodule

module D_FF_ED(input D, input CLK, input RESET, output Q);

    wire nclk;
    wire detector;

    not(nclk,CLK);
    and(detector , CLK , nclk);


    D_a slave(.d(D),.en(detector),.rstn(RESET),.q(Q));


endmodule