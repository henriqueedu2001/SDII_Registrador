`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_processor #(parameter WORDSIZE = 64, parameter SIZE = 32) ;
    reg [WORDSIZE-1:0] num1;
    reg [WORDSIZE-1:0] num2;
    reg operation_in;
    wire[WORDSIZE-1:0] result;
	
	// instância da Unit Under Test
	processor uut(
		.num1(num1),
        .num2(num2),
        .operation_in(operation_in),
        .result(result)
	);
	
	// 
	initial begin
        /* Teste 01 - escrita de um input em um endereço de memória */

        num1 = 64'h0000_0000_0000_0005;
        num2 = 64'h0000_0000_0000_0002;
        $monitor ("Somando %D + %D\n", num1, num2);
        #100;
        $monitor ("Resultado : %D\n", 
            result
        );
        #100;

        num1 = 64'h0000_0000_0005_000a;
        num2 = 64'h0000_0000_0000_0002;
        $monitor ("Somando %D + %D\n", num1, num2);
        #100;
        $monitor ("Resultado : %D\n", 
            result
        );
        #100;


        num1 = 64'h0000_0000_0001_0005;
        num2 = 64'h0000_0002_0000_0000;
        $monitor ("Somando %D + %D\n", num1, num2);
        #100;
        $monitor ("Resultado : %D\n", 
            result
        );
        #100;

   
	end
endmodule
