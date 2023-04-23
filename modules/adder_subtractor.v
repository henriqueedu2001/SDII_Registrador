/* módulo que faz operações de soma e subtração, sendo:
    -> operation = 0: adição
    -> operation = 1: subtração
*/
module adder_subtractor #(parameter N = 64) (
    input wire [N-1:0] factor_a, // primeiro número da operação
    input wire [N-1:0] factor_b, // segundo número da operação
    input wire operation, // operação a ser realizada
    output wire signed [N-1:0] result
);
    /* armazena o valor de factor_b com sinal correto, a depender de operation*/
    wire [N-1:0] signed_b;

    /* calcula o negativo de factor_b, caso operation = 1 */
    negative neg(factor_b, operation, signed_b);

    /* calcula o resultado da operação */
    assign result = factor_a + signed_b;

endmodule //somador