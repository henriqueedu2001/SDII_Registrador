`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_neg;
	reg [7:0] number;
	reg enable;
    wire [7:0] result;
	
	// instância da Unit Under Test
	negative uut(
		.number(number),
		.enable(enable),
        .result(result)
	);
	
	// 
	initial begin
		#100 $monitor ("testing for negatives numbers");
		#100 $monitor ("enable = 0: remains the same");
		#100 $monitor ("enable = 1: returns the opposite");
		

		number = 8'b00110110;
		enable = 0;
		$monitor ("number = %B; enable = %B; result: %B", number, enable, result);
		#100;

		number = 8'b00110110;
		enable = 0;
		$monitor ("number = %B; enable = %B; result: %B", number, enable, result);
		#100;

		number = 8'b00110110;
		enable = 1;
		$monitor ("number = %B; enable = %B; result: %B", number, enable, result);
		#100;

		number = 8'b10110011;
		enable = 1;
		$monitor ("number = %B; enable = %B; result: %B", number, enable, result);
		#100;

		number = 8'b00000000;
		enable = 1;
		$monitor ("number = %B; enable = %B; result: %B", number, enable, result);
		#100;

		number = 8'b11111111;
		enable = 1;
		$monitor ("number = %B; enable = %B; result: %B", number, enable, result);
		#100;
	end
endmodule