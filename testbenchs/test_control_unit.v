`timescale 1ns/1ps

module test_control_unit #(parameter WORDSIZE = 64, parameter SIZE = 32);
    reg clk; /* sinal de clock */
    reg [SIZE-1:0] instruction; /* instrução de 32 bits */
    wire rf_write_enable; /* enable do register file */
    wire [4:0] rf_write_addr; /* endereço para escrita, do register file */
    wire [4:0] rf_addr_a; /* endereço a do register file */
    wire [4:0] rf_addr_b; /* endereço b do register file */
    wire dm_write_enable; /* write enable do data memory */
    wire [4:0] dm_write_addr; /* write addr do data memory */
    wire dm_read; /* read do data memory */
    wire alu_op; /* operação a ser realizada pela ALU */


endmodule