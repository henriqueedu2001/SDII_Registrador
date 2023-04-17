module adder_subtractor (
    input  wire [7:0] factor_a, // first number of the operation, in 8 bits
    input  wire [7:0] factor_b, // second number of the operation, in 8 bits
    input wire operation, // 0 -> addition (a+b); 1 -> subtraction (a-b)
    output wire signed [7:0] result
);
    wire [7:0] signed_b;

    negative neg(factor_b, operation, signed_b);

    assign result = factor_a + signed_b;

endmodule //somador