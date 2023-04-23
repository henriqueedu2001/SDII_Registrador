/* calcula o valor absoluto de um número binário x de N bits, em notação de complemento de dois*/
module absolute_value #(parameter N = 64) (
    input wire signed [N-1:0] number, /* numero x, cujo módulo se deseja calcular */
    output reg signed [N-1:0] abs /* módulo do número x */
);
    wire signed [N-1:0] opposite; /* armazena o valor do negativo de x (opposite = -x) */
    wire input_number_signal; /* armazena o sinal de x */

    //number_signal num_sig(number, input_number_signal);
    //assign opposite = negative(number, 1'b0, input_number);
    
    /* cálculo do valor absoluto pela definição de módulo */
    always @(number) begin
        if(number > 0) begin
            abs <= number; /* |x| = x, para x >= 0 */
        end
        else begin
            abs <= ~number + 1; /* |x| = -x, para x < 0 */
        end
        
    end

endmodule