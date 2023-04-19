module number_signal (
    input wire signed [7:0] number, // first number of the operation, in 8 bits
    output reg num_signal
);

    always @(number) begin
        if(number > 0)
            num_signal <= 0;
        else
            num_signal <= 1;
    end

endmodule //valor absoluto