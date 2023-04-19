/* Calcula o negativo de um número, em complemento de dois, quando ativo
    -> enable = 0: módulo desativado; retorno do número original
    -> enable = 1: módulo ativado; retorno do oposto do número original
*/
module negative #(parameter N = 8) (
    input wire [N-1:0] number, /* número cujo oposto se deseja calcular */
    input wire enable, /* define se o módulo está ativado ou não */
    output reg [N-1:0] result /* resultado da operação */
);
    /* cálculo do negativo do número */
    wire [N-1:0] neg;
    assign neg = ~number + 1;

    /* ativação com mudança nas entradas */
    always @(number or enable) begin
        case (enable)
            0: result <= number; /* módulo desativado, retornar number */
            1: result <= neg; /* módulo ativado, retornar -number */
        endcase
    end

endmodule //somador