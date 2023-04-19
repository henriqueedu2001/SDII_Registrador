/* calcula o sinal de um número em complemento de dois, segunfo a convenção:
    ->num_signal = 0: número positivo ou nulo
    ->num_signal = 1: número negativo
*/
module number_signal #(parameter N = 8) (
    input wire signed [N-1:0] number, /* número de N bits, cujo sinal se deseja saber*/
    output reg num_signal /* sinal do número de N bits, sendo 0 para positivos e nulos e 1 para negativos */
);

    /* ativado com mudança na entrada */
    always @(number) begin
        if(number >= 0)
            num_signal <= 0; /* números positivos ou nulos */
        else
            num_signal <= 1; /* números neagtivo ou nulos */
    end

endmodule