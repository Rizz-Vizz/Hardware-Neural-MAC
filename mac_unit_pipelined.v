module mac_unit_pipelined(
    input clk, rst,
    input [7:0] x, w,
    output [15:0] y
);

    wire [15:0] p;
    reg  [15:0] p_reg;
    wire [15:0] next_y;
    wire unused_cout;

    multiplier m1(x, w, p);

    always @(posedge clk or posedge rst) begin
        if (rst)
            p_reg <= 16'b0;
        else
            p_reg <= p;
    end

    ripple_adder_16 radd_acc(.a(y), .b(p_reg), .cin(1'b0), .sum(next_y), .cout(unused_cout));
    accumulator a1(clk, rst, next_y, y);

endmodule
