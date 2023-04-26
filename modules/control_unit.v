/* unidade de controle (versão simplificada) */
module control_unit #(parameter WORDSIZE = 64, parameter SIZE = 32)(
    input clk, /* sinal de clock */
    input wire [SIZE-1:0] instruction, /* instrução de 32 bits */
    output reg rf_write_enable, /* enable do register file */
    output reg [4:0] rf_write_addr, /* endereço para escrita, do register file */
    output reg [4:0] rf_addr_a, /* endereço a do register file */
    output reg [4:0] rf_addr_b, /* endereço b do register file */
    output reg dm_write_enable, /* write enable do data memory */
    output reg [4:0] dm_write_addr, /* write addr do data memory */
    output reg dm_read, /* read do data memory */
    output reg alu_op /* operação a ser realizada pela ALU */
);

    /* possíveis operações */
    localparam 
        load_word_instruction = 2'b00,
        store_word_instruction = 2'b01,
        add_instruction = 2'b10,
        sub_instruction = 2'b11;
    
    /* converte a intrução para os 4 tipos básicos de operações (implementadas até agora) */
    wire [1:0] simplified_instruction;
    assign simplified_instruction = instruction[1:0];

    /* registrador temporário, para armazenas resultados intermediários */
    wire [4:0] rf_temp;
    
    /* conexão register file com alu */
    wire [WORDSIZE-1:0] rf_alu_addr_a;
    wire [WORDSIZE-1:0] rf_alu_addr_b;

    /* conexão alu (result) com data memory (data_input) */
    wire [WORDSIZE-1:0] alu_dm_d_input;

    /* conexão data memory com register file */
    wire [WORDSIZE-1:0] dm_rf_data_input;

    /* instanciação do register file */
    register_file rf (
        clk,
        rf_write_enable,
        rf_write_addr,
        dm_rf_data_input,
        rf_addr_a,
        rf_addr_b,
        rf_alu_addr_a,
        rf_alu_addr_b
    );

    /* instaciação do data memory */
    data_memory dm (
        clk,
        dm_write_addr,
        alu_dm_d_input,
        dm_write_enable,
        dm_read,
        dm_rf_data_input
    );

    /* executar instrução load word */
    always @(posedge clk) begin
        if(simplified_instruction == load_word_instruction) begin
                /*
                state = rest
                rf_write_enable = 0;
                rf_write_addr = 0;
                rf_addr_a = 0;
                rf_addr_b = 0;
                dm_write_enable = 0;
                dm_write_addr = 0;
                dm_read = 0;
                alu_op = 0;

                state = writing_imm
                rf_write_enable = 1;
                rf_write_addr = rf_temp;
                rf_addr_a = 0;
                rf_addr_b = 0;
                dm_write_enable = 0;
                dm_write_addr = 0;
                dm_read = 0;
                alu_op = 0;
                */
            $display("load_word_instruction");
        end
    end

    /* executar instrução store word */
    always @(posedge clk) begin
        if(simplified_instruction == store_word_instruction) begin
            $display("store_word_intruction");
        end
    end

    /* executar instrução add */
    always @(posedge clk) begin
        if(simplified_instruction == add_instruction) begin
            $display("add_intruction");
        end
    end

    /* executar instrução sub */
    always @(posedge clk) begin
        if(simplified_instruction == sub_instruction) begin
            $display("sub_intruction");
        end
    end

endmodule