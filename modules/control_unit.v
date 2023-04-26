/* unidade de controle (versão simplificada) */
module control_unit #(parameter WORDSIZE = 64, parameter SIZE = 32)(
    input clk, /* sinal de clock */
    input wire [SIZE-1:0] instruction, /* instrução de 32 bits */

    /* REGISTER FILE (prefixo rf_ para identificação) */
    output reg rf_write_enable, /* enable do register file */
    output reg [4:0] rf_write_addr, /* endereço para escrita, do register file */
    output reg [WORDSIZE-1:0] rf_write_data, /* valor a ser escrito no register file */
    output reg [4:0] rf_addr_a, /* endereço a do register file */
    output reg [4:0] rf_addr_b, /* endereço b do register file */

    /* DATA MEMORY (prefixo dm_ para identificação) */
    output reg dm_write_enable, /* write enable do data memory */
    output reg [4:0] dm_write_addr, /* write addr do data memory */
    output reg [WORDSIZE-1:0] dm_data_input, /* write data do data memory */
    output reg dm_read, /* read do data memory */

    /* ALU (prefixo alu_ para identificação) */
    output reg alu_op /* operação a ser realizada pela ALU */
);
    /* sinais de controle 
        -> rf_write_enable = 0;
        -> rf_write_addr = 0;
        -> rf_write_data = 0;
        -> rf_addr_a = 0;
        -> rf_addr_b = 0;
        -> dm_write_enable = 0;
        -> dm_write_addr = 0;
        -> dm_data_input = 0;
        -> dm_read = 0;
        -> alu_op = 0;
    */

    /* possíveis operações */
    localparam 
        load_word_instruction = 2'b00,
        store_word_instruction = 2'b01,
        add_instruction = 2'b10,
        sub_instruction = 2'b11;
    
    /* estados possíveis */
    localparam
        state_s0 = 4'b0001, /* rest state */
        state_s1 = 4'b0010,
        state_s2 = 4'b0011,
        state_s3 = 4'b0100,
        state_s4 = 4'b0101,
        state_s5 = 4'b0110,
        state_s6 = 4'b0111;
    
    /* estados da fsm */
	reg [3:0] current_state, next_state;

    /* inicialização das variáveis de estado */
    initial begin
        current_state = state_s0;
        next_state = state_s0;
    end
    
    /* converte a intrução para os 4 tipos básicos de operações (implementadas até agora) */
    wire [1:0] simplified_instruction;
    assign simplified_instruction = instruction[1:0];

    /* obtenção dos parâmetros da instrução tipo l */
    wire [11:0] l_type_immediate;
    wire [4:0] l_type_rs1;
    wire [2:0] l_type_funct3;
    wire [4:0] l_type_rd;
    wire [6:0] l_type_op_code;    

    l_type_instruction l_type_instruc (
        instruction,
        l_type_immediate,
        l_type_rs1,
        l_type_funct3,
        l_type_rd,
        l_type_op_code
    );

    /* obtenção dos parâmetros da instrução tipo s */
    wire [6:0] s_type_funct7;
    wire [4:0] s_type_rs2;
    wire [4:0] s_type_rs1;
    wire [2:0] s_type_funct3;
    wire [4:0] s_type_rd;
    wire [6:0] s_type_op_code;    

    s_type_instruction s_type_instruc (
        instruction,
        s_type_funct7,
        s_type_rs2,
        s_type_rs1,
        s_type_funct3,
        s_type_rd,
        s_type_op_code
    );

    /* obtenção dos parâmetros da instrução tipo r */
    wire [6:0] r_type_funct7;
    wire [4:0] r_type_rs2;
    wire [4:0] r_type_rs1;
    wire [2:0] r_type_funct3;
    wire [4:0] r_type_rd;
    wire [6:0] r_type_op_code;    
    
    r_type_instruction r_type_instruc (
        instruction,
        r_type_funct7,
        r_type_rs2,
        r_type_rs1,
        r_type_funct3,
        r_type_rd,
        r_type_op_code
    );

    /* executar instrução load word */
    always @(posedge clk) begin
        if(simplified_instruction == load_word_instruction) begin
            case (current_state)
                /* estado do repouso */
                state_s0: begin
                    rf_write_enable = 0;
                    rf_write_addr = 0;
                    rf_write_data = 0;
                    rf_addr_a = 0;
                    rf_addr_b = 0;
                    dm_write_enable = 0;
                    dm_write_addr = 0;
                    dm_data_input = 0;
                    dm_read = 0;
                    alu_op = 0;
                    next_state = state_s1;
                end

                /* estado de escrita no register file */
                state_s1: begin
                    rf_write_enable = 1;
                    rf_write_addr = 0;
                    rf_write_data = 0;
                    rf_addr_a = 0;
                    rf_addr_b = 0;
                    dm_write_enable = 0;
                    dm_write_addr = 0;
                    dm_data_input = 0;
                    dm_read = 0;
                    alu_op = 0;
                    next_state = state_s0;
                end
            endcase
        end
    end

    /* executar instrução store word */
    always @(posedge clk) begin
        if(simplified_instruction == store_word_instruction) begin
            case (current_state)
                /* estado de repouso */
                state_s0: begin
                    rf_write_enable = 0;
                    rf_write_addr = 0;
                    rf_write_data = 0;
                    rf_addr_a = 0;
                    rf_addr_b = 0;
                    dm_write_enable = 0;
                    dm_write_addr = 0;
                    dm_data_input = 0;
                    dm_read = 0;
                    alu_op = 0;
                    next_state = state_s1;
                end

                /* estado de escrita no data memory */
                state_s1: begin
                    rf_write_enable = 0;
                    rf_write_addr = 0;
                    rf_write_data = 0;
                    rf_addr_a = 0;
                    rf_addr_b = 0;
                    dm_write_enable = 1;
                    dm_write_addr = 0;
                    dm_data_input = 0;
                    dm_read = 0;
                    alu_op = 0;
                    next_state = state_s0;
                end
            endcase
        end
    end

    /* executar instrução add */
    always @(posedge clk) begin
        if(simplified_instruction == add_instruction) begin
            case (current_state)
                /* estado de repouso */
                state_s0: begin
                    next_state = state_s1;
                end

                /* estado de escrita no register file */
                state_s1: begin
                    next_state = state_s0;
                end
            endcase
        end
    end

    /* executar instrução sub */
    always @(posedge clk) begin
        if(simplified_instruction == sub_instruction) begin
            case (current_state)
                /* estado de repouso */
                state_s0: begin
                    next_state = state_s1;
                end

                /* estado de escrita no register file */
                state_s1: begin
                    next_state = state_s2;
                end
            endcase
        end
    end

    /* transição de estados na borda de descida */
    always @(negedge clk) begin
        current_state <= next_state;
    end

endmodule