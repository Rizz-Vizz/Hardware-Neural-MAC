`timescale 1ns / 1ps

module neuron_layer_tb;

    reg clk, rst;
    reg [31:0] x_in, w_in;
    wire [63:0] y_out;

    neuron_layer #(.NUM_NEURONS(4)) uut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .w_in(w_in),
        .y_out(y_out)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (!rst)
            $display("t=%0t | y0=%0d y1=%0d y2=%0d y3=%0d",
                      $time,
                      y_out[15:0], y_out[31:16], y_out[47:32], y_out[63:48]);
    end

    initial begin
        $dumpfile("neuron_layer.vcd");
        $dumpvars(0, neuron_layer_tb);

        clk = 0; rst = 1; x_in = 0; w_in = 0;
        #20 rst = 0;

        x_in = {8'd255,  8'd7,   8'd2,   8'd5};
        w_in = {8'd255,  8'd1,   8'd2,   8'd2};
        #10;

        x_in = {8'd0,    8'd1,   8'd3,   8'd10};
        w_in = {8'd0,    8'd7,   8'd3,   8'd3};
        #10;

        x_in = 0; w_in = 0;
        #10;
        #10;

        $display("---");
        $display("Expected final accumulator values: y0=40 (5*2+10*3), y1=13 (2*2+3*3), y2=14 (7*1+1*7), y3=65025 (255*255)");
        $display("Expected POST-ReLU values:          y0=40, y1=13, y2=14, y3=0 (clipped -- this is the caveat, not a bug in the adder chain)");
        $display("Actual final values (from y_out):   y0=%0d y1=%0d y2=%0d y3=%0d",
                  y_out[15:0], y_out[31:16], y_out[47:32], y_out[63:48]);

        $finish;
    end

endmodule
