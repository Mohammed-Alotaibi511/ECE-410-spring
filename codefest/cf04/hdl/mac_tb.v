`timescale 1ns/1ps

module mac_tb;

    logic clk;
    logic rst;
    logic signed [7:0] a;
    logic signed [7:0] b;
    logic signed [31:0] out;

    mac dut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .out(out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        a = 0;
        b = 0;

        @(posedge clk);
        rst = 0;

        a = 8'sd3;
        b = 8'sd4;
        repeat (3) @(posedge clk);
        #1;

        if (out !== 32'sd36) begin
            $display("FAIL: expected 36, got %0d", out);
            $finish;
        end

        a = -8'sd5;
        b = 8'sd2;
        repeat (2) @(posedge clk);
        #1;

        if (out !== 32'sd16) begin
            $display("FAIL: expected 16, got %0d", out);
            $finish;
        end

        $display("PASS: mac_correct.v passed testbench");
        $finish;
    end

endmodule
