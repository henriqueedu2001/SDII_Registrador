/* datapath do processador, com register file e o data memory */
module processor #(parameter WORDSIZE = 64, parameter SIZE = 32)(
    input [WORDSIZE-1:0] num1,
    input [WORDSIZE-1:0] num2, 
    input operation_in,
    output reg [63:0] result

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

    /* somador registers*/
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

	wire clk; // clock
	clock_gen clock (clk);

	/* mudança de estados em borda de subida */
    always @(posedge clk) begin
         state <= next_state;
	end

    always@(state) begin
		state <= next_state; // mudanca de estados 
		// proximos estados
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
    
	/* ações dos estados, para cada alteração em state */
    always@(state) begin
    	case(state)
    		s0: begin
                dm_addr <= 5'b00000;
                dm_data_input <= num1;
                dm_write_enable <= 1'b1;
                dm_read <= 1'b1;
            end

    		s1: begin
                rf_addr_a <= 5'b00000;
                rf_write_addr <= 5'b00000;
                rf_write_en <= 1'b1;
                rf_write_data <= dm_data_output;
			end

    		s3: begin
                dm_addr <= 5'b00001;
                dm_data_input <= num2;
                dm_write_enable <= 1'b1;
                dm_read <= 1'b1;
            end

 			s4: begin
				rf_addr_b <= 5'b00001;
                rf_write_addr <= 5'b00001;
                rf_write_en <= 1'b1;
                rf_write_data <= dm_data_output;
			end

            s5: begin
                factor_a <= rf_data_a;
                factor_b <= rf_data_b;
                result <= adder_result;
            end

			default: next_state <= s0;
	    endcase
    end
    
endmodule