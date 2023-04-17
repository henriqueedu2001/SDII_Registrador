module negative (
    input  wire [7:0] number, // input
    input wire enable, // 0 ->  returns number; 1 -> returns -number
    output reg [7:0] result
);
    wire [7:0] neg;
    assign neg = ~number + 1;

    always @(number or enable) begin
        case (enable)
            0: result <= number;
            1: result <= ~number + 1;
        endcase
    end

endmodule //somador