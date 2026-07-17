module neuron_layer #(
    parameter NUM_NEURONS = 4
) (
    input clk, rst,

    input  [8*NUM_NEURONS-1:0]  x_in,
    input  [8*NUM_NEURONS-1:0]  w_in,
    output [16*NUM_NEURONS-1:0] y_out
);

    genvar n;
    generate
        for (n = 0; n < NUM_NEURONS; n = n + 1) begin : neuron
            wire [7:0]  x_n = x_in[8*n +: 8];
            wire [7:0]  w_n = w_in[8*n +: 8];
            wire [15:0] y_raw;
            wire [15:0] y_relu;

            mac_unit_pipelined mac_inst(
                .clk(clk),
                .rst(rst),
                .x(x_n),
                .w(w_n),
                .y(y_raw)
            );

            relu relu_inst(
                .y_in(y_raw),
                .y_out(y_relu)
            );

            assign y_out[16*n +: 16] = y_relu;
        end
    endgenerate
endmodule
