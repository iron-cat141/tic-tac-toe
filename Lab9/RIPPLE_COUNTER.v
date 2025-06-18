module D_a(input d, input en, input rstn, output reg q);
    always @(*) begin
        if(rstn == 1'b1) q = 0;
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

module RIPPLE_COUNTER (input CLK, input RESET, output [3:0] COUNT);
    
    wire [3:0] Qn;
    not(Qn[0],COUNT[0]);
    not(Qn[1],COUNT[1]);
    not(Qn[2],COUNT[2]);
    not(Qn[3],COUNT[3]);

    D_FF_ED store0(.D(Qn[0]),.CLK(CLK),.RESET(RESET),.Q(COUNT[0]));
    D_FF_ED store1(.D(Qn[1]),.CLK(Qn[0]),.RESET(RESET),.Q(COUNT[1]));
    D_FF_ED store2(.D(Qn[2]),.CLK(Qn[1]),.RESET(RESET),.Q(COUNT[2]));
    D_FF_ED store3(.D(Qn[3]),.CLK(Qn[2]),.RESET(RESET),.Q(COUNT[3]));

endmodule