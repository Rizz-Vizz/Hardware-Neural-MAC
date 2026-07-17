`timescale 1ns / 1ps

module multiplier_tb;

    reg [7:0] a, b;
    wire [15:0] p;
    integer errors;

    multiplier uut (
        .a(a),
        .b(b),
        .p(p)
    );

    task check(input [7:0] av, input [7:0] bv);
        begin
            a = av; b = bv;
            #10;
            if (p !== (av * bv)) begin
                $display("FAIL: a=%0d b=%0d -> p=%0d (expected %0d)", av, bv, p, av * bv);
                errors = errors + 1;
            end else begin
                $display("PASS: a=%0d b=%0d -> p=%0d", av, bv, p);
            end
        end
    endtask

    initial begin
        $dumpfile("multiplier.vcd");
        $dumpvars(0, multiplier_tb);

        errors = 0;

        check(0, 0);
        check(1, 1);
        check(5, 2);
        check(10, 3);
        check(15, 15);
        check(255, 255);
        check(128, 2);
        check(200, 100);
        check(1, 255);
        check(255, 0);

        if (errors == 0)
            $display("ALL TESTS PASSED.");
        else
            $display("%0d TEST(S) FAILED.", errors);

        $finish;
    end

endmodule
