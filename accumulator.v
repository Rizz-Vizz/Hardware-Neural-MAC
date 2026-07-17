module accumulator(
    input clk, rst,
    input [15:0] d,
    output reg [15:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 16'd0;
        else
            q <= d;
    end
endmodule
