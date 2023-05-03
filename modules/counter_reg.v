module counter_reg(
    input clk, /* sinal de clock */
    input reset, /* seta o valor do counter para 0 quando ativado */
    output reg[3:0] cr_data_output); /* valor do counter */

    always @ (posedge clk) begin 
        if(reset) /* reset aitvo, cr_data_output recebe 0 */
            cr_data_output <= 0;  
        else /* reset inativo, cr_data_output recebe seu valor incrementado de 1 */
            cr_data_output <= cr_data_output + 1;
    end
endmodule