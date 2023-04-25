/* Unidade Lógico Aritmética */
module alu #(parameter WORDSIZE = 64, parameter SIZE = 32) (
    input wire [WORDSIZE-1:0] a_in, /* entrada a */
    input wire [WORDSIZE-1:0] b_in, /* entrada b */
    input wire [4:0] op, /* operação a ser realizada com a e b */
    output wire signed [WORDSIZE-1:0] result /* resultado da operação aritmética */
);

    /* tipos de operações executadas pela ALU */
    localparam 
        op_get_a = 5'b00000, /* result = a */
        op_get_b = 5'b00001, /* result = b */
        op_add = 5'b00010, /* result = a + b */
        op_sub = 5'b00011; /* result = a - b */
    
    /* registrador para resultado final */
    reg [WORDSIZE-1:0] final_result;
    assign result = final_result;

    /* verificação se a operação é soma ou subtração */
    wire add_sub_op; 
    assign add_sub_op = ~op[0];
    wire signed [WORDSIZE-1:0] add_sub_result;

    /* instanciação do somador-subtrator em complemento de dois */
    adder_subtractor add_sub(
        a_in,
        b_in,
        add_sub_op,
        add_sub_result
    );

    /* lógica combinacional */
    always @(a_in or b_in or op) begin
        case(op)
            /* operação retornar valor a */
            op_get_a: begin
                final_result = a_in;
            end

            /* operação retornar valor b */
            op_get_b: begin
                final_result = b_in;
            end

            /* operação de soma a + b */
            op_add: begin
                final_result = add_sub_result;
            end

            /* operação de subtração a - b */
            op_sub: begin
                final_result = add_sub_result;
            end

            /* operação padrão retornar 0 */
            default: begin
                final_result = 0;
            end
        endcase
    end

endmodule