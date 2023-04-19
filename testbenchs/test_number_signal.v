`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_numsig;
	reg signed [7:0] number;
    wire num_signal;
	
	// instância da Unit Under Test
	number_signal uut(
		.number(number),
		.num_signal(num_signal)
	);
	
	// 
	initial begin
		number = 8'b00000111;
		$monitor ("number = %B = %D; signal = %B", number, number,num_signal);
		#100;

        number = 8'b11110110;
		$monitor ("number = %B = %D; signal = %B", number, number,num_signal);
		#100;

        number = 8'b01110110;
		$monitor ("number = %B = %D; signal = %B", number, number,num_signal);
		#100;

        number = 8'b11111111;
		$monitor ("number = %B = %D; signal = %B", number, number,num_signal);
		#100;

        number = 8'b00000000;
		$monitor ("number = %B = %D; signal = %B", number, number,num_signal);
		#100;
	end
endmodule