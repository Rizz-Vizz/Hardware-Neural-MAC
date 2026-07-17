module mac_unit(
    input clk, rst,
    input [7:0] x, w,
    output [15:0] y
);
    wire [15:0] p;
    wire [15:0] next_y;
    wire unused_cout;

    multiplier m1(x, w, p);
    ripple_adder_16 radd_acc(.a(y), .b(p), .cin(1'b0), .sum(next_y), .cout(unused_cout));
    accumulator a1(clk, rst, next_y, y);

endmodule
