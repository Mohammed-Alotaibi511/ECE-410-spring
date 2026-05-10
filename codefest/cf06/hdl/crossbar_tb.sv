module crossbar_tb;

    logic clk;
    logic rst;
    logic signed [7:0] in0, in1, in2, in3;
    logic signed [15:0] out0, out1, out2, out3;

    crossbar_mac dut (
        .clk(clk),
        .rst(rst),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        in0 = 0;
        in1 = 0;
        in2 = 0;
        in3 = 0;

        #10 rst = 0;

        in0 = 10;
        in1 = 20;
        in2 = 30;
        in3 = 40;

        #10;

        if (out0 == -40 && out1 == 0 && out2 == -20 && out3 == -20) begin
            $display("PASS");
            $display("out0 = %0d", out0);
            $display("out1 = %0d", out1);
            $display("out2 = %0d", out2);
            $display("out3 = %0d", out3);
        end else begin
            $display("FAIL");
            $display("out0 = %0d", out0);
            $display("out1 = %0d", out1);
            $display("out2 = %0d", out2);
            $display("out3 = %0d", out3);
        end

        #10 $finish;
    end

endmodule
