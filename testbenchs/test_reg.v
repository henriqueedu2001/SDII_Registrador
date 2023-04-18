`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_reg;
    reg clk;
    reg load_signal;
    reg [7:0] data_input;
    wire [7:0] data_output;
	
	// instância da Unit Under Test
	register uut(
		.clk(clk),
		.load_signal(load_signal),
        .data_input(data_input),
        .data_output(data_output)
	);
	
	// 
	initial begin
        clk = 0;
        load_signal = 0;
        data_input = 8'b01010101;
		$monitor ("clk = %B; load = %B; data_output: %B", clk, load_signal, data_output);
		#100;

        clk = 1;
        load_signal = 0;
		$monitor ("clk = %B; load = %B; data_output: %B", clk, load_signal, data_output);
		#100;

        clk = 0;
        load_signal = 0;
		$monitor ("clk = %B; load = %B; data_output: %B", clk, load_signal, data_output);
		#100;

        clk = 0;
        load_signal = 1;
		$monitor ("clk = %B; load = %B; data_output: %B", clk, load_signal, data_output);
		#100;

        clk = 1;
        load_signal = 1;
		$monitor ("clk = %B; load = %B; data_output: %B", clk, load_signal, data_output);
		#100;

        clk = 0;
        load_signal = 1;
		$monitor ("clk = %B; load = %B; data_output: %B", clk, load_signal, data_output);
		#100;

        clk = 0;
        load_signal = 0;
		$monitor ("clk = %B; load = %B; data_output: %B", clk, load_signal, data_output);
		#100;
	end
endmodule