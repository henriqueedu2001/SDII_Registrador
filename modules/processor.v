/* datapath do processador, com register file e o data memory */
module processor #(parameter WORDSIZE = 64, parameter SIZE = 32)(
	input clk,
	input [4:0] rs1, /* endereço de rs1 */
	input [4:0] rs2, /* endereço de rs2 */
	input [WORDSIZE-1:0] rd_in, /* valor de input de rd */
	input [6:0] op_code, /* operação a ser realizada */
	output reg [WORDSIZE-1:0] rs1_out, /* valor de saída de rs1 */
	output reg [WORDSIZE-1:0] rs2_out, /* valor de saída de rs2 */
	output reg [WORDSIZE-1:0] debug_variable /* valor teste, para debugs */
);
	/* conjunto de operações possíveis */
	localparam 
		op_none = 7'b0000000, /* inativo */
		op_store = 7'b0000001, /* operação store */
		op_add = 7'b0000010, /* operação add */
		op_sub = 7'b0000011; /* operação sub */
	
	/* conjunto de estados do sistema */
	localparam 
		state_none = 7'b0000000, /* repouso/início */
		state_writing_rf = 7'b0000001, /* escrevendo no register_file */
		state_alu_computing = 7'b0000010, /* computando um resultado aritmético na ALU */
		state_writing_dm = 7'b0000011, /* escrevendo no data_memory */
		state_reading_dm = 7'b0000100; /* faz leitura do data_memory */
	
	/* estados da fsm */
	reg [2:0] current_state, next_state;

	/* controla fim da operação */
	reg finished_op;

	/* fios para instanciação do register file (prefixo rf_ para identificação) */	
    reg rf_write_en;
    wire [4:0] rf_write_addr;
    wire [WORDSIZE-1:0] rf_write_data;
    wire [4:0] rf_addr_a;
    wire [4:0] rf_addr_b;
    wire [WORDSIZE-1:0] rf_data_a;
    wire [WORDSIZE-1:0] rf_data_b;

	/* fios para instanciação do data_memory (prefixo dm_ para identificação) */	
	wire [4:0] dm_addr;
    wire [WORDSIZE-1:0] dm_data_input;
    reg dm_write_enable;
    reg dm_read;
    wire [WORDSIZE-1:0] dm_data_output;

	/* fios para instanciação do adder_subtractor (prefixo adder_sub_ para identificação) */
	/* (aqui, no futuro, haverá uma ALU) */
	wire [WORDSIZE-1:0] adder_sub_factor_a;
    wire [WORDSIZE-1:0] adder_sub_factor_b;
    wire adder_sub_operation;
    wire signed [WORDSIZE-1:0] adder_sub_result;

	/* instanciação do register file (rf) */
	register_file rf(
		clk,
		rf_write_en,
		rs1,
		rd_in,
		rs1,
		rs2,
		rf_data_a,
		rf_data_b
	);

	/* instanciação do data memory (dm) */
	data_memory dm(
		clk,
		dm_addr,
		dm_data_input,
		dm_write_enable,
		dm_read,
		dm_data_output
	);

	/* instanciação do adder_subtractor (futura ALU) */
	adder_subtractor adder_sub(
		adder_sub_factor_a,
		adder_sub_factor_b,
		adder_sub_operation,
		adder_sub_result
	);

	initial begin
		finished_op = 0;
		current_state = state_none;
		next_state = state_none;
	end

	/* ativação em borda de subida do clock */
	always @(posedge clk) begin
		case (op_code)
			op_store: begin
				case (current_state)
					state_none: begin
						rf_write_en = 1;
						dm_write_enable = 0;
						dm_read = 0;
						$display("->State: %B\n%B %B %B\n%B %H", current_state, rf_write_en, dm_write_enable, dm_read, rs1, rf_data_a);
						next_state = state_writing_rf;
					end
					state_writing_rf: begin
						rf_write_en = 1;
						dm_write_enable = 0;
						dm_read = 0;
						$display("->State: %B\n%B %B %B\n%B %H", current_state, rf_write_en, dm_write_enable, dm_read, rs1, rf_data_a);
						next_state = state_writing_dm;
					end
					state_writing_dm: begin
						rf_write_en = 0;
						dm_write_enable = 1;
						dm_read = 0;
						$display("->State: %B\n%B %B %B\n%B %H", current_state, rf_write_en, dm_write_enable, dm_read, rs1, rf_data_a);
						next_state = state_reading_dm;
					end
					state_reading_dm: begin
						rf_write_en = 0;
						dm_write_enable = 0;
						dm_read = 1;
						finished_op = 1;
						$display("->State: %B\n%B %B %B\n%B %H", current_state, rf_write_en, dm_write_enable, dm_read, rs1, rf_data_a);
						next_state = state_none;
					end
				endcase
			end
		endcase
	end

	always @(negedge clk) begin
		if (finished_op == 0)
			current_state <= next_state;
	end
	
endmodule

/* Nesta versão, o processador ainda está em estágio primitivo de desenvolvimento.
Por simplicidade, ele realiza apenas as seguintes operações:
	- op_code = 7'b0000000 -> inativo
	- op_code = 7'b0000001 -> store de rd em rs1
	- op_code = 7'b0000010 -> soma dos valores armazenados em rs1 e rs2 (será escrita em rd)
	- op_code = 7'b0000011 -> subtração dos valores armazenados em rs1 e rs2 (será escrita em rd)
1. STORE
A operação
	STR r4, [r7]
Significa armazenar r4 do register file em mem[r7], no data memory
	-> rs1 = 5'd4 = 5'b00100
	-> rs2 = 5'dx = 5'xxxxxx
	-> rd = 5'd7 = 5'b00111
	-> op_code = 7'b0000001

2. SOMA
A operação
	add r10, r2, r3
Significa armazenar em mem[r10] o valor r[2] + r[3] (que estão no register file)
	-> rs1 = 5'd2 = 5'b00010
	-> rs2 = 5'd3 = 5'b00011
	-> rd = 5'd10 = 5'b01010
	-> op_code = 7'b0000010

3. SUBTRAÇÃO
A operação
	sub r14, r4, r5
Significa armazenar em mem[r14] o valor r[4] - r[5] (que estão no register file)
	-> rs1 = 5'd4 = 5'b00100
	-> rs2 = 5'd5 = 5'b00101
	-> rd = 5'd14 = 5'b01110
	-> op_code = 7'b0000011
 */