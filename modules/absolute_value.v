module absolute_value (
    input wire signed [7:0] number, // first number of the operation, in 8 bits
    output reg [7:0] result
);
    wire input_number_singal;
    number_signal num_sig(number, input_number_singal);

    always @(number) begin
        if(number > 0)
            result <= number;
    end

endmodule //valor absoluto