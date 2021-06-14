module all_gates(a,b,andd,orr,nott_a,nott_b,xorr,xnorr,buff_a,buff_b,nandd,norr);
    input a;
    input b;

    output andd;
    output orr;
    output nott_a;
    output nott_b;
    output xorr;
    output xnorr;
    output buff_a;
    output buff_b;
    output nandd;
    output norr;

    assign andd   = a&b;
    assign orr    = a|b;
    assign nott_a = ~a;
    assign nott_b = ~b;
    assign xorr   = a^b;
    assign xnorr  = ~(a^b);
    assign nandd  = ~(a&b);
    assign norr   = ~(a|b);
    assign buff_a = a;
    assign buff_b = b;

endmodule