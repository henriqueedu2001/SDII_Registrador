`timescale 1ns/1ps

module test_alu #(parameter WORDSIZE = 64, parameter SIZE = 32);
    reg [WORDSIZE-1:0] a_in;
    reg [WORDSIZE-1:0] b_in;
    reg [4:0] op;
    wire [WORDSIZE-1:0] result;

    alu uut (
        a_in,
        b_in,
        op,
        result
    );

    initial begin
        a_in = 64'h0000_0000_0000_3333;
        b_in = 64'h0000_0000_0000_1111;
        op = 5'b00000;
        $monitor ("->get_a operation\na = %H\nb = %H\nop = %B\nresult = %H\n", a_in, b_in, op, result);
        #100;

        a_in = 64'h0000_0000_0000_3333;
        b_in = 64'h0000_0000_0000_1111;
        op = 5'b00001;
        $monitor ("->get_b operation\na = %H\nb = %H\nop = %B\nresult = %H\n", a_in, b_in, op, result);
        #100;

        a_in = 64'h0000_0000_0000_3333;
        b_in = 64'h0000_0000_0000_1111;
        op = 5'b00010;
        $monitor ("->add operation\na = %H\nb = %H\nop = %B\nresult = %H\n", a_in, b_in, op, result);
        #100;

        a_in = 64'h0000_0000_0000_3333;
        b_in = 64'h0000_0000_0000_1111;
        op = 5'b00011;
        $monitor ("->sub operation\na = %H\nb = %H\nop = %B\nresult = %H\n", a_in, b_in, op, result);
        #100;
    end
endmodule