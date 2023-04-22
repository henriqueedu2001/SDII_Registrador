`timescale 1ns/1ps

/* módulo de teste para a rom */
module test_register_file #(parameter WORDSIZE = 64, parameter SIZE = 32) ;
	reg clk; 

	reg write_en;
	reg [4:0] write_addr; 
	reg [WORDSIZE - 1:0] write_data; 
	
	reg [4:0] addr_a; 
	wire [WORDSIZE-1:0] data_a; 

	reg [4:0] addr_b; 
	wire [WORDSIZE-1:0] data_b;

	// instância da Unit Under Test
	reg_file_teste uut(
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
        clk = 0;
        write_en = 0;
		write_addr = 5'b00001; 
		write_data = 64'b1010101010101010101010101010101010101010101010101010101010101010; 
        addr_a = 5'b00001;
		addr_b = 5'b00010;
        $monitor ("clock = %B; write_en = %B, write_addr = %B; write_data = %B", clk, write_en, write_addr, write_data);
		$monitor ("addr_a = %B, data_a = %B", addr_a, data_a); 
		$monitor ("addr_b = %B, data_b = %B", addr_b, data_b); 
        #100;

		clk = 1;
        write_en = 1;
		write_addr = 5'b00001; 
		write_data = 64'b1010101010101010101010101010101010101010101010101010101010101010; 
        addr_a = 5'b00001;
		addr_b = 5'b00010;
        $monitor ("clock = %B; write_en = %B, write_addr = %B; write_data = %B", clk, write_en, write_addr, write_data);
		$monitor ("addr_a = %B, data_a = %B", addr_a, data_a); 
		$monitor ("addr_b = %B, data_b = %B", addr_b, data_b); 
        #100;

		clk = 0;
        write_en = 0;
		write_addr = 5'b00010; 
		write_data = 64'b1111111111111111111111111111111111111111111111111111111111111111; 
        addr_a = 5'b00001;
		addr_b = 5'b00010;
        $monitor ("clock = %B; write_en = %B, write_addr = %B; write_data = %B", clk, write_en, write_addr, write_data);
		$monitor ("addr_a = %B, data_a = %B", addr_a, data_a); 
		$monitor ("addr_b = %B, data_b = %B", addr_b, data_b); 
        #100;

		clk = 1;
        write_en = 1;
		write_addr = 5'b00010; 
		write_data = 64'b1111111111111111111111111111111111111111111111111111111111111111; 
        addr_a = 5'b00001;
		addr_b = 5'b00010;
        $monitor ("clock = %B; write_en = %B, write_addr = %B; write_data = %B", clk, write_en, write_addr, write_data);
		$monitor ("addr_a = %B, data_a = %B", addr_a, data_a); 
		$monitor ("addr_b = %B, data_b = %B", addr_b, data_b); 
        #100;

		clk = 0;
        write_en = 0;
		write_addr = 5'b00100; 
		write_data = 64'b1111111111111111111111111111111100000000000000000000000000000000; 
        addr_a = 5'b00010;
		addr_b = 5'b00100;
        $monitor ("clock = %B; write_en = %B, write_addr = %B; write_data = %B", clk, write_en, write_addr, write_data);
		$monitor ("addr_a = %B, data_a = %B", addr_a, data_a); 
		$monitor ("addr_b = %B, data_b = %B", addr_b, data_b); 
        #100;

		clk = 1;
        write_en = 1;
		write_addr = 5'b00100; 
		write_data = 64'b1111111111111111111111111111111100000000000000000000000000000000; 
        addr_a = 5'b00010;
		addr_b = 5'b00100;
        $monitor ("clock = %B; write_en = %B, write_addr = %B; write_data = %B", clk, write_en, write_addr, write_data);
		$monitor ("addr_a = %B, data_a = %B", addr_a, data_a); 
		$monitor ("addr_b = %B, data_b = %B", addr_b, data_b); 
        #100;

	end
endmodule 