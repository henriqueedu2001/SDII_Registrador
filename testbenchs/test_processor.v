`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_processor #(parameter WORDSIZE = 64, parameter SIZE = 32);
    reg clk;
	reg [4:0] rs1; /* endereço de rs1 */
	reg [4:0] rs2; /* endereço de rs2 */
	reg [SIZE-1:0] rd_in; /* valor de input de rd */
	reg [6:0] op_code; /* operação a ser realizada */
	wire [WORDSIZE-1:0] rs1_out; /* valor de saída de rs1 */
	wire [WORDSIZE-1:0] rs2_out; /* valor de saída de rs2 */
    wire [WORDSIZE-1:0] debug_variable; /* valor de saída de rs2 */

    // instância da Unit Under Test
    processor uut (
        clk,
        rs1,
        rs2,
        rd_in,
        op_code,
        rs1_out,
        rs2_out,
        debug_variable
    );

    initial begin
        op_code = 7'b0000001;
        clk = 0;
        rs1 = 5'b00100;
		$monitor ("rs1_out = %H", debug_variable);
		#100;

        clk = 1;
		$monitor ("rs1_out = %H", debug_variable);
		#100;

        clk = 0;
		$monitor ("rs1_out = %H", debug_variable);
		#100;

        clk = 1;
		$monitor ("rs1_out = %H", debug_variable);
		#100;

        clk = 0;
		$monitor ("rs1_out = %H", debug_variable);
		#100;
	end

endmodule
