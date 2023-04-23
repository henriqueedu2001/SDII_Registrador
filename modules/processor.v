/* Nesta versão, o processador ainda está em estágio primitivo de desenvolvimento.
Por simplicidade, ele realiza apenas as seguintes operações:
	- op_code = 7'b0000000 -> inativo
	- op_code = 7'b0000001 -> store de rd em rs1
	- op_code = 7'b0000010 -> soma dos valores armazenados em rs1 e rs2 (será escrita em )
	- op_code = 7'b0000011 -> subtração dos valores armazenados em rs1 e rs2 (será escrita em )
	
*/    

/* datapath do processador, com register file e o data memory */
module processor #(parameter WORDSIZE = 64, parameter SIZE = 32)(
	input clk,
	input [4:0] rs1, /* endereço de rs1 */
	input [4:0] rs2, /* endereço de rs2 */
	input [31:0] rd_in, /* valor de input de rd */
	input [6:0] op_code, /* operação a ser realizada */
	output rs1_out, /* valor de saída de rs1 */
	output rs2_out /* valor de saída de rs2 */
);
	/*  
	1. SOMA
	A operação
		add x10, x2, x3
	significa armazenar em mem[10] o valor x[2] + x[3] (que estão no register file)
		-> rs1 = 5'd2 = 5'b00010
		-> rs2 = 5'd3 = 5'b00011
		-> rd = 5'd10 = 5'b01010
		-> op_code = 7'b0000010

	2. SUBTRAÇÃO
	A operação
		sub x14, x4, x5
	significa armazenar em mem[14] o valor x[4] - x[5] (que estão no register file)
		-> rs1 = 5'd4 = 5'b00100
		-> rs2 = 5'd5 = 5'b00101
		-> rd = 5'd14 = 5'b01110
		-> op_code = 7'b0000011
	 */

	
endmodule