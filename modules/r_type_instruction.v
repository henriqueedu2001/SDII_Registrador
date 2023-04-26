module r_type_instruction #(parameter WORDSIZE = 64, parameter SIZE = 32)(
    input wire [SIZE-1:0] instruction, /* instrução "crua" */
    output wire [6:0] funct7, /* funct7 da instrução (7 bits) */
    output wire [4:0] rs2, /* rs2 da instrução (5 bits) */
    output wire [4:0] rs1, /* rs1 da instrução (5 bits) */
    output wire [2:0] funct3, /* funct3 da instrução (3 bits) */
    output wire [4:0] rd, /* rd da instrução (5 bits) */
    output wire [6:0] op_code /* op_code da instrução (7 bits) */
);
    /* instruction = 32'b1100100_00010_01100_111_00100_0000110 (exemplo) */
    assign funct7 = instruction[31:25];
    assign rs2 = instruction[24:20];
    assign rs1 = instruction[19:15];
    assign funct3 = instruction[14:12];
    assign rd = instruction[11:7];
    assign op_code = instruction[6:0];
    
endmodule