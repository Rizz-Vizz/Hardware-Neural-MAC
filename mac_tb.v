`timescale 1ns / 1ps
module mac_tb;
    reg clk, rst;
    reg [7:0] x, w;
    wire [15:0] y;

    mac_unit uut(clk, rst, x, w, y);

    always #5 clk = ~clk;

    always @(posedge clk) begin
        if (!rst)
            $display("t=%0t | x=%0d w=%0d | x*w=%0d | accumulator y=%0d",
                      $time, x, w, x * w, y);
    end

    initial begin
        $dumpfile("mac_unit.vcd");
        $dumpvars(0, mac_tb);

        clk = 0; rst = 1; x = 0; w = 0;
        #20 rst = 0;

        x = 5; w = 2;
        #10;

        x = 10; w = 3;
        #10;

        x = 0; w = 0;
        #10;

        $display("Simulation complete. Expected final accumulator value = (5*2)+(10*3) = 40.");
        $finish;
    end
endmodule
