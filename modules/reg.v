module register #(parameter N = 8) (
    input wire clk,
    input wire load_signal,
    input wire [N-1:0] data_input,
    output reg [N-1:0] data_output);
    

    always @(posedge clk) begin
        if(load_signal)
            data_output <= data_input;
    end

endmodule //reg
