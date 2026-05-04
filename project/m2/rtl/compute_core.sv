// Simple compute core (MAC unit)
// Synchronous, active-high reset

module compute_core (
    input logic clk,
    input logic rst,
    input logic signed [7:0] a,
    input logic signed [7:0] b,
    input logic valid_in,
    output logic signed [31:0] out,
    output logic valid_out
);

    always_ff @(posedge clk) begin
        if (rst) begin
            out <= 0;
            valid_out <= 0;
        end else begin
            if (valid_in) begin
                out <= out + (a * b);
                valid_out <= 1;
            end else begin
                valid_out <= 0;
            end
        end
    end

endmodule
