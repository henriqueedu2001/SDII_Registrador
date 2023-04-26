module l_type_instruction #(parameter WORDSIZE = 64, parameter SIZE = 32)(
    input wire [SIZE-1:0] instruction, /* instrução "crua" */
    output wire [11:0] immediate, /* immediate da instrução (12 bits) */
    output wire [4:0] rs1, /* rs1 da instrução (5 bits) */
    output wire [2:0] funct3, /* funct3 da instrução (3 bits) */
    output wire [4:0] rd, /* rd da instrução (5 bits) */
    output wire [6:0] op_code /* op_code da instrução (7 bits) */
);
    /* instruction = 32'b001100101011_01110_111_01101_0001001 (exemplo) */
    assign immediate = instruction[31:20];
    assign rs1 = instruction[19:15];
    assign funct3 = instruction[14:12];
    assign rd = instruction[11:7];
    assign op_code = instruction[6:0];
    
endmodule