`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_adder_subtractor;
	reg [7:0] factor_a;
	reg [7:0] factor_b;
	reg operation;
	reg [7:0] expected;
    wire signed [7:0] result;
	
	// instância da Unit Under Test
	adder_subtractor uut(
		.factor_a(factor_a),
		.factor_b(factor_b),
		.operation(operation),
        .result(result)
	);
	
	// 
	initial begin
		factor_a = 8'b00110110;
		factor_b = 8'b00010101;
		operation = 0;
		expected = 8'b01001011;
		$monitor("a = %B; b = %B; operation = %B; result = %B; expected = %B", factor_a, factor_b, operation, result, expected);
		#100;

		factor_a = 8'b00110110;
		factor_b = 8'b00010101;
		operation = 1;
		expected = 8'b00100001;
		$monitor("a = %B; b = %B; operation = %B; result = %B; expected = %B", factor_a, factor_b, operation, result, expected);
		#100;

		factor_a = 8'b10111000;
		factor_b = 8'b01010111;
		operation = 0;
		expected = 8'b00001111;
		$monitor("a = %B; b = %B; operation = %B; result = %B; expected = %B", factor_a, factor_b, operation, result, expected);
		#100;

		factor_a = 8'b10111000;
		factor_b = 8'b01010111;
		operation = 1;
		expected = 8'b01100001;
		$monitor("a = %B; b = %B; operation = %B; result = %B; expected = %B", factor_a, factor_b, operation, result, expected);
		#100;

	end
endmodule