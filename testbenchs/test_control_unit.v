`timescale 1ns/1ps

module test_control_unit #(parameter WORDSIZE = 64, parameter SIZE = 32);
    reg clk; /* sinal de clock */
    reg [SIZE-1:0] instruction; /* instrução de 32 bits */

    /* REGISTER FILE (prefixo rf_ para identificação) */
    wire rf_write_enable; /* enable do register file */
    wire [4:0] rf_write_addr; /* endereço para escrita, do register file */
    wire [WORDSIZE-1:0] rf_write_data; /* valor a ser escrito no register file */
    wire [4:0] rf_addr_a; /* endereço a do register file */
    wire [4:0] rf_addr_b; /* endereço b do register file */

    /* DATA MEMORY (prefixo dm_ para identificação) */
    wire dm_write_enable; /* write enable do data memory */
    wire [4:0] dm_write_addr; /* write addr do data memory */
    wire [WORDSIZE-1:0] dm_data_input; /* write data do data memory */
    wire dm_read; /* read do data memory */

    /* ALU (prefixo alu_ para identificação) */
    wire alu_op; /* operação a ser realizada pela ALU */

    /* instanciação da Unit Under Test */
    control_unit uut (
        clk,
        instruction,
        rf_write_enable,
        rf_write_addr,
        rf_write_data,
        rf_addr_a,
        rf_addr_b,
        dm_write_enable,
        dm_write_addr,
        dm_data_input,
        dm_read,
        alu_op
    );

    initial begin
        /* instrução de load word */
        instruction = 32'h0000_0000;
        
        clk = 0; #100; 
        $monitor (
            "->instrução de load word\n\nEstado: s0 = repouso\n",
            "rf_write_enable = ", rf_write_enable, "\n",
            "rf_write_addr = ", rf_write_addr, "\n",
            "rf_write_data = ", rf_write_data, "\n",
            "rf_addr_a = ", rf_addr_a, "\n",
            "rf_addr_b = ", rf_addr_b, "\n",
            "dm_write_enable = ", dm_write_enable, "\n",
            "dm_write_addr = ", dm_write_addr, "\n",
            "dm_data_input = ", dm_data_input, "\n",
            "dm_read = ", dm_read, "\n",
            "alu_op = ", alu_op, "\n"
        );
        clk = 1; #100;

        clk = 0; #100;
        $monitor (
            "Estado: s1 = escrevendo no register file\n",
            "rf_write_enable = ", rf_write_enable, "\n",
            "rf_write_addr = ", rf_write_addr, "\n",
            "rf_write_data = ", rf_write_data, "\n",
            "rf_addr_a = ", rf_addr_a, "\n",
            "rf_addr_b = ", rf_addr_b, "\n",
            "dm_write_enable = ", dm_write_enable, "\n",
            "dm_write_addr = ", dm_write_addr, "\n",
            "dm_data_input = ", dm_data_input, "\n",
            "dm_read = ", dm_read, "\n",
            "alu_op = ", alu_op, "\n"
        );
        clk = 1; #100;

        /* instrução de store word */
        instruction = 32'h0000_0001;
        
        clk = 0; #100; 
        $monitor (
            "->instrução de store word\n\nEstado: s0 = repouso\n",
            "rf_write_enable = ", rf_write_enable, "\n",
            "rf_write_addr = ", rf_write_addr, "\n",
            "rf_write_data = ", rf_write_data, "\n",
            "rf_addr_a = ", rf_addr_a, "\n",
            "rf_addr_b = ", rf_addr_b, "\n",
            "dm_write_enable = ", dm_write_enable, "\n",
            "dm_write_addr = ", dm_write_addr, "\n",
            "dm_data_input = ", dm_data_input, "\n",
            "dm_read = ", dm_read, "\n",
            "alu_op = ", alu_op, "\n"
        );
        clk = 1; #100;

        clk = 0; #100;
        $monitor (
            "Estado: s1 = escrevendo no data memory\n",
            "rf_write_enable = ", rf_write_enable, "\n",
            "rf_write_addr = ", rf_write_addr, "\n",
            "rf_write_data = ", rf_write_data, "\n",
            "rf_addr_a = ", rf_addr_a, "\n",
            "rf_addr_b = ", rf_addr_b, "\n",
            "dm_write_enable = ", dm_write_enable, "\n",
            "dm_write_addr = ", dm_write_addr, "\n",
            "dm_data_input = ", dm_data_input, "\n",
            "dm_read = ", dm_read, "\n",
            "alu_op = ", alu_op, "\n"
        );
        clk = 1; #100;

        /* instrução add */
        instruction = 32'h0000_0002;
        
        clk = 0; #100; 
        $monitor (
            "->instrução add\n\nEstado: s0 = repouso\n",
            "rf_write_enable = ", rf_write_enable, "\n",
            "rf_write_addr = ", rf_write_addr, "\n",
            "rf_write_data = ", rf_write_data, "\n",
            "rf_addr_a = ", rf_addr_a, "\n",
            "rf_addr_b = ", rf_addr_b, "\n",
            "dm_write_enable = ", dm_write_enable, "\n",
            "dm_write_addr = ", dm_write_addr, "\n",
            "dm_data_input = ", dm_data_input, "\n",
            "dm_read = ", dm_read, "\n",
            "alu_op = ", alu_op, "\n"
        );
        clk = 1; #100;

        clk = 0; #100;
        $monitor (
            "Estado: s1 = escrevendo no register file\n",
            "rf_write_enable = ", rf_write_enable, "\n",
            "rf_write_addr = ", rf_write_addr, "\n",
            "rf_write_data = ", rf_write_data, "\n",
            "rf_addr_a = ", rf_addr_a, "\n",
            "rf_addr_b = ", rf_addr_b, "\n",
            "dm_write_enable = ", dm_write_enable, "\n",
            "dm_write_addr = ", dm_write_addr, "\n",
            "dm_data_input = ", dm_data_input, "\n",
            "dm_read = ", dm_read, "\n",
            "alu_op = ", alu_op, "\n"
        );
        clk = 1; #100;

        /* instrução sub */
        instruction = 32'h0000_0003;
        
        clk = 0; #100; 
        $monitor (
            "->instrução sub\n\nEstado: s0 = repouso\n",
            "rf_write_enable = ", rf_write_enable, "\n",
            "rf_write_addr = ", rf_write_addr, "\n",
            "rf_write_data = ", rf_write_data, "\n",
            "rf_addr_a = ", rf_addr_a, "\n",
            "rf_addr_b = ", rf_addr_b, "\n",
            "dm_write_enable = ", dm_write_enable, "\n",
            "dm_write_addr = ", dm_write_addr, "\n",
            "dm_data_input = ", dm_data_input, "\n",
            "dm_read = ", dm_read, "\n",
            "alu_op = ", alu_op, "\n"
        );
        clk = 1; #100;

        clk = 0; #100;
        $monitor (
            "Estado: s1 = escrevendo no register file\n",
            "rf_write_enable = ", rf_write_enable, "\n",
            "rf_write_addr = ", rf_write_addr, "\n",
            "rf_write_data = ", rf_write_data, "\n",
            "rf_addr_a = ", rf_addr_a, "\n",
            "rf_addr_b = ", rf_addr_b, "\n",
            "dm_write_enable = ", dm_write_enable, "\n",
            "dm_write_addr = ", dm_write_addr, "\n",
            "dm_data_input = ", dm_data_input, "\n",
            "dm_read = ", dm_read, "\n",
            "alu_op = ", alu_op, "\n"
        );
        clk = 1; #100;
    end

endmodule