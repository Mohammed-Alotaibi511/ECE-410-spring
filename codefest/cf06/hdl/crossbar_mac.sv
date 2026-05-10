module crossbar_mac (
    input  logic clk,
    input  logic rst,
    input  logic signed [7:0] in0,
    input  logic signed [7:0] in1,
    input  logic signed [7:0] in2,
    input  logic signed [7:0] in3,
    output logic signed [15:0] out0,
    output logic signed [15:0] out1,
    output logic signed [15:0] out2,
    output logic signed [15:0] out3
);

    always_ff @(posedge clk) begin
        if (rst) begin
            out0 <= 0;
            out1 <= 0;
            out2 <= 0;
            out3 <= 0;
        end else begin
            out0 <=  in0 + in1 - in2 - in3;
            out1 <= -in0 + in1 + in2 - in3;
            out2 <=  in0 - in1 + in2 - in3;
            out3 <= -in0 - in1 - in2 + in3;
        end
    end

endmodule
