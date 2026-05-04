module tb_compute_core;

    logic clk;
    logic rst;
    logic signed [7:0] a, b;
    logic valid_in;
    logic signed [31:0] out;
    logic valid_out;

    compute_core uut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .valid_in(valid_in),
        .out(out),
        .valid_out(valid_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim/wave.vcd");
        $dumpvars(0, tb_compute_core);
        clk = 0;
        rst = 1;
        valid_in = 0;
        a = 0;
        b = 0;

        #10 rst = 0;

        #10 a = 3; b = 4; valid_in = 1;
        #10 valid_in = 0;

        #10 a = -5; b = 2; valid_in = 1;
        #10 valid_in = 0;

        #50 $finish;
    end

endmodule
