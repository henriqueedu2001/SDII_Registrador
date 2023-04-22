`timescale 1ns/100ps

/* Módulo gerador do clocl*/
module clock_gen(clock);
output reg clock;
initial 
    #5 clock = 1;
always 
    #50 clock = ~clock;

endmodule