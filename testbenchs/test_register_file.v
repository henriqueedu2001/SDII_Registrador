`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_register_file #(parameter WORDSIZE = 64, parameter SIZE = 32) ;
	reg clk; 
	reg write_en;
	reg [4:0] write_addr; 
	reg [WORDSIZE - 1:0] write_data; 	
	reg [4:0] addr_a; 
	reg [4:0] addr_b; 

	wire [WORDSIZE-1:0] data_a; 
	wire [WORDSIZE-1:0] data_b;

	// instância da Unit Under Test
	register_file uut(
		.clk(clk),
		.write_en(write_en), 
		.write_addr(write_addr), 
		.write_data(write_data),
		.addr_a(addr_a),
		.data_a(data_a),
		.addr_b(addr_b),
		.data_b(data_b)
	);
	
	// 
	initial begin
		/* Teste 01 - escrita de um valor em um registrador do banco */
        clk = 0;
        write_en = 1;
		write_addr = 5'b01101; 
		write_data = 64'h0000_0000_0000_aabb; 
        addr_a = 5'b01101;
		addr_b = 5'b00110;
		$monitor ("-> Escrita de x = %H em addr = %B\n", write_data, write_addr);
		#100;
        $monitor ("clock = %B; write_en = %B;\nwrite_addr = %B; write_data = %H\naddr_a = %B, data_a = %H\naddr_b = %B, data_b = %H\n",
			clk, 
			write_en, 
			write_addr, 
			write_data,
			addr_a,
			data_a,
			addr_b,
			data_b
		);
        #100;

		clk = 1;
        write_en = 1;
		write_addr = 5'b01101; 
		write_data = 64'h0000_0000_0000_aabb; 
        addr_a = 5'b01101;
		addr_b = 5'b00110;
        $monitor ("clock = %B; write_en = %B;\nwrite_addr = %B; write_data = %H\naddr_a = %B, data_a = %H\naddr_b = %B, data_b = %H\n",
			clk, 
			write_en, 
			write_addr, 
			write_data,
			addr_a,
			data_a,
			addr_b,
			data_b
		);
        #100;

		clk = 0;
        write_en = 1;
		write_addr = 5'b01101; 
		write_data = 64'h0000_0000_0000_aabb; 
        addr_a = 5'b01101;
		addr_b = 5'b00100;
        $monitor ("clock = %B; write_en = %B;\nwrite_addr = %B; write_data = %H\naddr_a = %B, data_a = %H\naddr_b = %B, data_b = %H\n",
			clk, 
			write_en, 
			write_addr, 
			write_data,
			addr_a,
			data_a,
			addr_b,
			data_b
		);
        #100;

		/* Teste 02 - escrita de um valor em um outro registrador do banco */

		clk = 0;
        write_en = 1;
		write_addr = 5'b00100; 
		write_data = 64'h0000_0000_e45f_b21f; 
        addr_a = 5'b01101;
		addr_b = 5'b00100;
		$monitor ("-> Escrita de x = %H em addr = %B\n", write_data, write_addr);
		#100;
        $monitor ("clock = %B; write_en = %B;\nwrite_addr = %B; write_data = %H\naddr_a = %B, data_a = %H\naddr_b = %B, data_b = %H\n",
			clk, 
			write_en, 
			write_addr, 
			write_data,
			addr_a,
			data_a,
			addr_b,
			data_b
		);
        #100;

		clk = 1;
        write_en = 1;
		write_addr = 5'b00100; 
		write_data = 64'h0000_0000_e45f_b21f; 
        addr_a = 5'b01101;
		addr_b = 5'b00100;
        $monitor ("clock = %B; write_en = %B;\nwrite_addr = %B; write_data = %H\naddr_a = %B, data_a = %H\naddr_b = %B, data_b = %H\n",
			clk, 
			write_en, 
			write_addr, 
			write_data,
			addr_a,
			data_a,
			addr_b,
			data_b
		);
        #100;

		clk = 0;
        write_en = 1;
		write_addr = 5'b00100; 
		write_data = 64'h0000_0000_e45f_b21f; 
        addr_a = 5'b01101;
		addr_b = 5'b00100;
        $monitor ("clock = %B; write_en = %B;\nwrite_addr = %B; write_data = %H\naddr_a = %B, data_a = %H\naddr_b = %B, data_b = %H\n",
			clk, 
			write_en, 
			write_addr, 
			write_data,
			addr_a,
			data_a,
			addr_b,
			data_b
		);
        #100;
	end
endmodule 