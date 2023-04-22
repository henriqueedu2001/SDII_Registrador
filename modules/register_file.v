module register_file #(parameter WORDSIZE = 64, parameter SIZE = 32) (
    input clk, /* sinal de clock */
    input write_en, /* habilita escrita */
    input [4:0] write_addr, /* endereço do registrador que recebe o valor a ser escrito */
    input [WORDSIZE-1:0] write_data, /* valor a ser escrito */
    input [4:0] addr_a, /* endereço do registrador A a ser lido */
    input [4:0] addr_b, /* endereço do registrador B a ser lido */
    output reg [WORDSIZE-1:0] data_a, /* valor lido pelo registrador A */
    output reg [WORDSIZE-1:0] data_b /* valor lido pelo registrador B */
); 

    /* fios para se ligar com os data_output de cada um dos registradores*/
    wire [WORDSIZE-1:0] data [SIZE-1:0];

    /*  */
    reg [WORDSIZE-1:0] data_output [SIZE-1:0];

    /* gera um array de SIZE = 32 (default) registradores do tipo register (ver reg.v) */
    generate
        for (genvar i = 0; i < SIZE; i = i + 1) begin: REG_INST
            register r0 (
                .clk(clk),
                .load_signal(write_en),
                .data_input(write_data),
                .data_output(data[i])
            );
        end
    endgenerate

    /* ativação em borda de subida */
    always @ (posedge clk) begin
        /* escrita síncrona com o clock */
        if(write_en) begin 
            data_output[write_addr] <= write_data;
        end
    end

    /* ativação em qualquer instante */
    always @ (*) begin
        /* leitura assíncrona com o clock */
        data_a <= data_output[addr_a]; 
        data_b <= data_output[addr_b];
    end

endmodule