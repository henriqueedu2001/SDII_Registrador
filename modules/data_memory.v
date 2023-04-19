/* bloco de memória do processador */
module Data_Memory #(parameter WORDSIZE = 64, parameter SIZE = 32) (
    input clk, /* sinal de clock */
    input [4:0] addr, /* endereço da memória, onde haverá leitura ou escrita */
    input [WORDSIZE-1:0] data_input, /* valor a ser escrito na memória */
    input write_enable,   // habilita escrita
    input read, /* habilita leitura */
    output [WORDSIZE-1:0]   read_data /* valor a ser lido, em caso de leitura */
);
    /* registradore em que serão armazenados os valores */
    reg [SIZE-1:0] memory [WORDSIZE:0];
    
    /* ativação em borda de subida */
    always @(posedge clk) begin
        /* escrita de dados na memória */
        if (write_enable) 
            memory[addr] <= data_input;
    end

    /* saída de leitura */
    assign read_data = (read==1'b1) ? memory[addr]: 64'd0; 

endmodule