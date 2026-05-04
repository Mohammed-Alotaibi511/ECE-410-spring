module tb_interface;

    logic clk;
    logic rst;
    logic signed [7:0] in_a, in_b;
    logic valid_in;
    logic signed [31:0] out;
    logic valid_out;

    m2_interface uut (
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
        clk = 0;
        rst = 1;
        valid_in = 0;

        #10 rst = 0;

        #10 in_a = 2; in_b = 3; valid_in = 1;
        #10 valid_in = 0;

        #40 $finish;
    end

endmodule
