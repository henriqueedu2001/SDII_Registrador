/* datapath do processador, com register file e o data memory */
module processor #(parameter WORDSIZE = 64, parameter SIZE = 32)(
    input [WORDSIZE-1:0] num1, // Primeiro número da operação
    input [WORDSIZE-1:0] num2, // Segundo número da operação
    input operation_in,        // Indicador da operação (1: subtração 0: soma)
    output reg [63:0] result   // Resultado da operação
);

	/* registradores do data memory */
    reg [4:0] dm_addr;                  
    reg [WORDSIZE-1:0] dm_data_input;
    reg dm_write_enable;
    reg dm_read;
    wire [WORDSIZE-1:0] dm_data_output;

	/* registradores do register file */
	reg rf_write_en;
	reg [4:0] rf_write_addr; 
	reg [WORDSIZE - 1:0] rf_write_data; 	
	reg [4:0] rf_addr_a; 
	reg [4:0] rf_addr_b; 

	wire [WORDSIZE-1:0] rf_data_a; 
	wire [WORDSIZE-1:0] rf_data_b;

    /* registradores do somador*/
    reg [WORDSIZE-1:0] factor_a;
	reg [WORDSIZE-1:0] factor_b;
	reg operation;
    wire signed [WORDSIZE-1:0] adder_result;

    /* parametros de estado */
    parameter [2:0] s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110;
    reg[2:0] state, next_state; /* variaveis de estado */ 

	/* instanciação do data_memory */
	data_memory dm(
		.clk(clk),
		.addr(dm_addr),
        .data_input(dm_data_input),
        .write_enable(dm_write_enable),
        .read(dm_read),
        .data_output(dm_data_output)
	);

	/* instanciação do register_file */
	register_file rf(
		.clk(clk),
		.write_en(rf_write_en), 
		.write_addr(rf_write_addr), 
		.write_data(rf_write_data),
		.addr_a(rf_addr_a),
		.data_a(rf_data_a),
		.addr_b(rf_addr_b),
		.data_b(rf_data_b)
	);

	/* instanciação do somador */
	adder_subtractor add1(
		.factor_a(factor_a),
		.factor_b(factor_b),
		.operation(operation_in),
        .result(adder_result)
	);

	/* gerando o clock */
	wire clk; 
	clock_gen clock (clk);

	initial begin
		state <= s0;
		next_state <= s0;
	end

	/* mudança de estados em borda de subida */
    always @(posedge clk) begin
         state <= next_state;
	end

	/* lógica da máquina de estados */
    always@(state) begin
		state <= next_state; 
		case(state)
			s0: next_state = s1; 
			s1: next_state = s2;
			s2: next_state = s3; 
			s3: next_state = s4; 
			s4: next_state = s5; 
            s5: next_state = s6;
            s6: next_state = s0;
			default: next_state = s0;
		endcase
	end
    
	/* ações de cada estado, para cada mudança de state */
    always@(state) begin
    	case(state)
			/* Escreve o valor de num1
			na posição 00000 do data_memory */
    		s0: begin
                dm_addr <= 5'b00000;
                dm_data_input <= num1;
                dm_write_enable <= 1'b1;
                dm_read <= 1'b1;
				$display ("s0 dm_data_output = %D", dm_data_output);
            end

			/* Escreve o valor de dm_data_output
			(que está lendoo o valor de num1)
			no registrador 00000 */
    		s1: begin
				$display ("s0 dm_data_output = %D", dm_data_output);
                rf_addr_a <= 5'b00000;
                rf_write_addr <= 5'b00000;
                rf_write_en <= 1'b1;
                rf_write_data <= dm_data_output;
			end

			/* Escreve o valor de num2
			na posição 00001 do data_memory */
    		s2: begin
				$display ("s0 dm_data_output = %D", dm_data_output);
                dm_addr <= 5'b00001;
                dm_data_input <= num2;
                dm_write_enable <= 1'b1;
                dm_read <= 1'b1;
            end

			/* Escreve o valor de dm_data_output
			(que está lendoo o valor de num2)
			no registrador 00001 */
 			s3: begin
				$display ("s0 dm_data_output = %D", dm_data_output);
				rf_addr_b <= 5'b00001;
                rf_write_addr <= 5'b00001;
                rf_write_en <= 1'b1;
                rf_write_data <= dm_data_output;
			end

			/* Coloca o que está sendo lido do registrador 00000
			no fator A do adder e o que está lido do registrador
			00001 no fator B do adder */
            s4: begin
                factor_a <= rf_data_a;
                factor_b <= rf_data_b;
            end

			/* Result recebe o resultado da operação do adder */
			s5: begin
				result <= adder_result;
			end

			default: next_state <= s0;
	    endcase
    end
    
endmodule