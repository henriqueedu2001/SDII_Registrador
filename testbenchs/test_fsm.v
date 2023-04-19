`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_fsm;
    reg clk;
    reg [7:0] input_a;
    reg [7:0] input_b;
    reg init;
    wire finished;
    wire [15:0] result;
	
	// instância da Unit Under Test
	fsm_example uut(
		.clk(clk),
		.input_a(input_a),
		.input_b(input_b),
        .init(init),
		.finished(finished),
        .result(result)
	);
	
	// 
	initial begin
		clk = 0;
		input_a = 8'b00000011;
		input_b = 8'b00001111;
        init = 1'b1;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 1;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 0;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 1;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 0;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 1;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 0;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 1;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 0;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;

        clk = 1;
		$monitor ("input_a = %B; input_b = %B; clk: %B, finished: %B, result = %B", input_a, input_b, clk, finished, result);
		#100;
	end
endmodule