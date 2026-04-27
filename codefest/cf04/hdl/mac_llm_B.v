module mac (
    input clk,
    input rst,
    input signed [7:0] a,
    input signed [7:0] b,
    output reg signed [31:0] out
);

    always @(posedge clk) begin
        if (!rst)
            out <= 0;
        else
            out <= out + a * b;
    end

endmodule
