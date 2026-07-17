module ripple_adder_16(
    input [15:0] a, b,
    input cin,
    output [15:0] sum,
    output cout
);

    wire [15:0] c;

    full_adder fa0(a[0], b[0], cin, sum[0], c[0]);

    genvar k;
    generate
        for (k = 1; k < 16; k = k + 1) begin : fa_chain
            full_adder fa(a[k], b[k], c[k-1], sum[k], c[k]);
        end
    endgenerate

    assign cout = c[15];
endmodule
