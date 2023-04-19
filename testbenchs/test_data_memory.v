`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_data_memory;
	reg [7:0] data_input;
	wire [7:0] data_output;
	
	// instância da Unit Under Test
	data_memory uut(
		.data_input(data_input),
		.data_output(data_output)
	);
	
	// 
	initial begin
        data_input = 2;
        $monitor ("data_input = %B, data_output = %B", data_input, data_output);
        #100;
	end
endmodule