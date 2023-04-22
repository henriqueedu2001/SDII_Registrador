module regfile #(parameter WORDSIZE = 64, parameter SIZE = 32) (
    input clk, 

    //Escrita 
    input write_en, // habilitar escrita 
    input [5:0] write_addr, // endereço do registrador a receber o valor escrito
    input [63:0] write_data, // valor a ser escrito

    // leitura1
    input  [5:0] addr_a,   // endereço do registrador A a ser lido
    output  [63:0] data_a, // valor lido pelo registrador A

    // leitura2
    input  [5:0] addr_b,   // endereço do registrador B a ser lido
    output  [63:0] data_b  // valor lido pelo registrador B
); 

    reg [WORDSIZE:0] memory [SIZE-1:0];

    generate
    for (genvar i = 0; i < 32; i = i + 1) begin : REG_INST
      register reg (
        .clk(clk),
        .load_signal(write_en),
        .data_input(write_data), // n sei se aqui tem que ser o write_data, deveria ser zerando todos os modulos n? 
        .data_output(data_out[i])
      );
    end
  endgenerate

  // A escrita é síncrona com o clock
    always @ (posedge clk) begin
        if(write_en) begin 
            
        end
    end

  // A leitura é assíncrona com o clock
  // Os outputs mudam assim que os inputs mudam
    always @ (addr_a or addr_b) begin

    end

endmodule