module top (
    input logic clk,
    input logic rst,
    input logic signed [7:0] in_a,
    input logic signed [7:0] in_b,
    input logic valid_in,
    output logic signed [31:0] out,
    output logic valid_out
);

    m2_interface iface (
        .clk(clk),
        .rst(rst),
        .in_a(in_a),
        .in_b(in_b),
        .valid_in(valid_in),
        .out(out),
        .valid_out(valid_out)
    );

endmodule