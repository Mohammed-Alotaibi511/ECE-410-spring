module tb_top;

    logic clk;
    logic rst;
    logic signed [7:0] in_a;
    logic signed [7:0] in_b;
    logic valid_in;

    logic signed [31:0] out;
    logic valid_out;

    top uut (
        .clk(clk),
        .rst(rst),
        .in_a(in_a),
        .in_b(in_b),
        .valid_in(valid_in),
        .out(out),
        .valid_out(valid_out)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("project/m3/sim/wave.vcd");
        $dumpvars(0, tb_top);

        clk = 0;
        rst = 1;

        in_a = 0;
        in_b = 0;
        valid_in = 0;

        #10 rst = 0;

        // send transaction through interface
        #10;
        in_a = 3;
        in_b = 4;
        valid_in = 1;

        #10;
        valid_in = 0;

        #20;

        if (out == 12)
            $display("PASS");
        else
            $display("FAIL");

        $display("out = %0d", out);

        #20 $finish;
    end

endmodule