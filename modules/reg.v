module register (
    input wire clk,
    input wire load_signal,
    input wire [7:0] data_input,
    output reg [7:0] data_output
);

    always @(posedge clk) begin
        if(load_signal)
            data_output <= data_input;
    end

endmodule //reg
