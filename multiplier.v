module multiplier(
    input [7:0] a, b,
    output [15:0] p
);

    wire [15:0] acc [0:8];
    assign acc[0] = 16'b0;

    genvar i, k;
    generate
        for (i = 0; i < 8; i = i + 1) begin : mult_stage
            wire [15:0] term;

            for (k = 0; k < 16; k = k + 1) begin : term_bit
                if (k >= i && k < i + 8)
                    assign term[k] = a[k-i] & b[i];
                else
                    assign term[k] = 1'b0;
            end

            wire unused_cout;
            ripple_adder_16 radd(
                .a(acc[i]),
                .b(term),
                .cin(1'b0),
                .sum(acc[i+1]),
                .cout(unused_cout)
            );
        end
    endgenerate

    assign p = acc[8];
endmodule
