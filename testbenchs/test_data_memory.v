`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_data_memory #(parameter WORDSIZE = 64, parameter SIZE = 32) ;
    reg clk;
    reg [4:0] addr;
    reg [WORDSIZE-1:0] data_input;
    reg write_enable;
    reg read;
    wire [WORDSIZE-1:0] data_output;
	
	// instância da Unit Under Test
	data_memory uut(
		.clk(clk),
		.addr(addr),
        .data_input(data_input),
        .write_enable(write_enable),
        .read(read),
        .data_output(data_output)
	);
	
	// 
	initial begin
        /* Teste 01 - escrita de um input em um endereço de memória */

        clk = 0;
        addr = 5'b00101;
        data_input = 64'h0000_0000_0005_e3a7;
        write_enable = 1;
        read = 0;
        $monitor ("-> Armazenando data_input = %H no endereço addr = %B\n", data_input, addr);
        #100;
        $monitor ("clock = %B; addr = %B; write = %B; read = %B;\ninput = %H;\noutput = %H;\n", 
            clk, 
            addr, 
            write_enable,
            read,
            data_input, 
            data_output
        );
        #100;

        clk = 1;
        addr = 5'b00101;
        data_input = 64'h0000_0000_0005_e3a7;
        write_enable = 1;
        read = 0;
        $monitor ("clock = %B; addr = %B; write = %B; read = %B;\ninput = %H;\noutput = %H;\n", 
            clk, 
            addr, 
            write_enable,
            read,
            data_input, 
            data_output
        );
        #100;

        clk = 0;
        addr = 5'b00101;
        data_input = 64'h0000_0000_0005_e3a7;
        write_enable = 0;
        read = 1;
        $monitor ("clock = %B; addr = %B; write = %B; read = %B;\ninput = %H;\noutput = %H;\n", 
            clk, 
            addr, 
            write_enable,
            read,
            data_input, 
            data_output
        );
        #100;

        /* Teste 02 - escrita de um input em um outro endereço de memória */
        clk = 0;
        addr = 5'b01110;
        data_input = 64'h0000_0000_001f_13a2;
        write_enable = 1;
        read = 0;
        $monitor ("-> Armazenando data_input = %H no endereço addr = %B\n", data_input, addr);
        #100;
        $monitor ("clock = %B; addr = %B; write = %B; read = %B;\ninput = %H;\noutput = %H;\n", 
            clk, 
            addr, 
            write_enable,
            read,
            data_input, 
            data_output
        );
        #100;

        clk = 1;
        addr = 5'b01110;
        data_input = 64'h0000_0000_001f_13a2;
        write_enable = 1;
        read = 0;
        $monitor ("clock = %B; addr = %B; write = %B; read = %B;\ninput = %H;\noutput = %H;\n", 
            clk, 
            addr, 
            write_enable,
            read,
            data_input, 
            data_output
        );
        #100;

        clk = 0;
        addr = 5'b01110;
        data_input = 64'h0000_0000_001f_13a2;
        write_enable = 0;
        read = 1;
        $monitor ("clock = %B; addr = %B; write = %B; read = %B;\ninput = %H;\noutput = %H;\n", 
            clk, 
            addr, 
            write_enable,
            read,
            data_input, 
            data_output
        );
        #100;

        /* Teste 03 - verificando se os valores estão devidamente armazenados */
        clk = 1;
        addr = 5'b00101;
        data_input = 64'h0000_0000_0000_0000;
        write_enable = 0;
        read = 1;
        $monitor ("-> Verificando se os dois valores estão devidamente armazenados\n");
        #100;
        $monitor ("clock = %B; addr = %B; write = %B; read = %B;\ninput = %H;\noutput = %H;\n", 
            clk, 
            addr, 
            write_enable,
            read,
            data_input, 
            data_output
        );
        #100;

        clk = 1;
        addr = 5'b01110;
        data_input = 64'h0000_0000_0000_0000;
        write_enable = 0;
        read = 1;
        $monitor ("clock = %B; addr = %B; write = %B; read = %B;\ninput = %H;\noutput = %H;\n", 
            clk, 
            addr, 
            write_enable,
            read,
            data_input, 
            data_output
        );
        #100;
	end
endmodule