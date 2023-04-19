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
		number = 8'b10110110;
		$monitor ("number = %B = %D; signal = %B", number, number,num_signal);
		#100;

	end
endmodule