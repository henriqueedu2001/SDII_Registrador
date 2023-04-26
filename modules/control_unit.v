/* unidade de controle (versão simplificada) */
module control_unit #(parameter WORDSIZE = 64, parameter SIZE = 32)(
    input clk, /* sinal de clock */
    input wire [SIZE-1:0] instruction, /* instrução de 32 bits */
    output reg rf_write_enable, /* enable do register file */
    output reg [4:0] rf_write_addr, /* endereço para escrita, do register file */
    output reg [WORDSIZE-1:0] rf_write_data, /* valor a ser escrito no register file */
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

    /* executar instrução load word */
    always @(posedge clk) begin
        if(simplified_instruction == load_word_instruction) begin
            case (current_state)
                state_s0: begin
                    $display("load word (s0)");
                    next_state = state_s1;
                end
                state_s1: begin
                    $display("load word (s1)");
                    next_state = state_s2;
                end
                state_s2: begin
                    $display("load word (s2)");
                    next_state = state_s3;
                end
                state_s3: begin
                    $display("load word (s3)");
                    next_state = state_s0;
                end
            endcase
        end
    end

    /* executar instrução store word */
    always @(posedge clk) begin
        if(simplified_instruction == store_word_instruction) begin
            case (current_state)
                state_s0: begin
                    $display("store word (s0)");
                    next_state = state_s1;
                end
                state_s1: begin
                    $display("store word (s1)");
                    next_state = state_s2;
                end
                state_s2: begin
                    $display("store word (s2)");
                    next_state = state_s3;
                end
                state_s3: begin
                    $display("store word (s3)");
                    next_state = state_s0;
                end
            endcase
        end
    end

    /* executar instrução add */
    always @(posedge clk) begin
        if(simplified_instruction == add_instruction) begin
            case (current_state)
                state_s0: begin
                    $display("add (s0)");
                    next_state = state_s1;
                end
                state_s1: begin
                    $display("add (s1)");
                    next_state = state_s2;
                end
                state_s2: begin
                    $display("add (s2)");
                    next_state = state_s3;
                end
                state_s3: begin
                    $display("add (s3)");
                    next_state = state_s0;
                end
            endcase
        end
    end

    /* executar instrução sub */
    always @(posedge clk) begin
        if(simplified_instruction == sub_instruction) begin
            case (current_state)
                state_s0: begin
                    $display("sub (s0)");
                    next_state = state_s1;
                end
                state_s1: begin
                    $display("sub (s1)");
                    next_state = state_s2;
                end
                state_s2: begin
                    $display("sub (s2)");
                    next_state = state_s3;
                end
                state_s3: begin
                    $display("sub (s3)");
                    next_state = state_s0;
                end
            endcase
        end
    end

    /* transição de estados na borda de descida */
    always @(negedge clk) begin
        current_state <= next_state;
    end

endmodule