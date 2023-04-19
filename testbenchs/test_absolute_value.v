`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_abs;
	reg signed [7:0] number;
	wire signed [7:0] abs;

	// instância da Unit Under Test
	absolute_value uut (
		.number(number),
		.abs(abs)
	);

	initial begin
		number = 8'b00001011;
		$monitor ("number x = %B = %D; |x| = %B = %D", number, number, abs, abs);
		#100;

		number = 8'b11011011;
		$monitor ("number x = %B = %D; |x| = %B = %D", number, number, abs, abs);
		#100;
		
		number = 8'b00000000;
		$monitor ("number x = %B = %D; |x| = %B = %D", number, number, abs, abs);
		#100;
		
		number = 8'b11111111;
		$monitor ("number x = %B = %D; |x| = %B = %D", number, number, abs, abs);
		#100;
		
		number = 8'b10001011;
		$monitor ("number x = %B = %D; |x| = %B = %D", number, number, abs, abs);
		#100;
		
	end

endmodule