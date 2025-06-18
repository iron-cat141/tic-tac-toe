module D_a(input d, input en, input rstn, output reg q);
    always @(*) begin
        if(rstn == 1'b0) q = 0;
        else if(en) q = d;
    end
endmodule

module D_FF_MS (input D, input CLK, input RESET, output Q);
    wire Qm;
    wire nclk,clk;
    wire negclk;

    not(negclk,CLK);
    not(clk , negclk);
    not(nclk,clk);

    D_a master(.d(D),.en(clk),.rstn(RESET),.q(Qm));
    D_a slave(.d(Qm),.en(nclk),.rstn(RESET),.q(Q));


endmodule
