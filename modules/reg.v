/* registrador, com sinal de load, sem reset e parametrizado para N bits de memória */
module register #(parameter N = 8) (
    input wire clk, /* sinal de clock */
    input wire load_signal, /* sinal de load, para escrever ou não novos valores */
    input wire [N-1:0] data_input, /* novos dados a serem escritos no registrador */
    output reg [N-1:0] data_output); /* dados já cadastrados no registrador */

    /* ação em borda de subida do clock */
    always @(posedge clk) begin
        /* escrever dados apenas com sinal se load (load_signal = 1) */
        if(load_signal)
            data_output <= data_input;
    end

endmodule
