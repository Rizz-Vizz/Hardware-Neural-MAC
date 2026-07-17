module relu(
    input  [15:0] y_in,
    output [15:0] y_out
);

    assign y_out = y_in[15] ? 16'b0 : y_in;
endmodule
