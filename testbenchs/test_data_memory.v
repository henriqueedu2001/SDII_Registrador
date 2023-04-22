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
        clk = 0;
        addr = 5'b00101;
        data_input = 64'b1010101010101010101010101010101010101010101010101010101010101010;
        write_enable = 1;
        read = 1;
        $monitor ("clock = %B; addr = %B, write = %B; input = %B, output = %B", clk, addr, write_enable, data_input, data_output);
        #100;

        clk = 1;
        addr = 5'b00101;
        data_input = 64'b1111111111111111111111111111111111111111111111111111111111111111;
        write_enable = 1;
        read = 1;
        $monitor ("clock = %B; addr = %B, write = %B; input = %B, output = %B", clk, addr, write_enable, data_input, data_output);
        #100;

        clk = 0;
        addr = 5'b00101;
        data_input = 64'b0000000000000000000000000000000000000000000000000000000000000001;
        write_enable = 0;
        read = 1;
        $monitor ("clock = %B; addr = %B, write = %B; input = %B, output = %B", clk, addr, write_enable, data_input, data_output);
        #100;

        clk = 1;
        addr = 5'b00101;
        data_input = 64'b0000000000000000000000000000000000000000000000000000000000000001;
        write_enable = 0;
        read = 1;
        $monitor ("clock = %B; addr = %B, write = %B; input = %B, output = %B", clk, addr, write_enable, data_input, data_output);
        #100;

        clk = 0;
        addr = 5'b00101;
        data_input = 64'b1010101010101010101010101010101010101010101010101010101010101010;
        write_enable = 1;
        read = 1;
        $monitor ("clock = %B; addr = %B, write = %B; input = %B, output = %B", clk, addr, write_enable, data_input, data_output);
        #100;

        clk = 1;
        addr = 5'b00101;
        data_input = 64'b1010101010101010101010101010101010101010101010101010101010101010;
        write_enable = 1;
        read = 1;
        $monitor ("clock = %B; addr = %B, write = %B; input = %B, output = %B", clk, addr, write_enable, data_input, data_output);
        #100;

        clk = 0;
        addr = 5'b00101;
        data_input = 64'b1010101010101010101010101010101010101010101010101010101010101010;
        write_enable = 0;
        read = 1;
        $monitor ("clock = %B; addr = %B, write = %B; input = %B, output = %B", clk, addr, write_enable, data_input, data_output);
        #100;
	end
endmodule