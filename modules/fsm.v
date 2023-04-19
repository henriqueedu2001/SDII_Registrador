module fsm_example #(parameter N = 8) (
    input clk,
    input [N-1:0] input_a,
    input [N-1:0] input_b,
    input init,
    output reg finished,
    output reg [2*N-1:0] result
);
    
    localparam [1:0]
        s0 = 2'b00,
        s1 = 2'b01,
        s2 = 2'b10,
        s3 = 2'b11;

    reg [1:0] current_state, next_state;
    reg [N-1:0] a_value;
    reg [N-1:0] counter;

    initial begin
        a_value <= 0;
        counter <= 0;
        finished <= 0;
        current_state <= 2'b00;
        result <= 0;
    end

    always @(posedge clk) begin
        case(current_state)
            2'b00: begin
                if(init == 1) begin
                    a_value <= input_a;
                    counter <= input_b;
                    result <= counter;
                    next_state <= 2'b01;
                end
            end
            2'b01: begin
                if(counter > 0) begin
                    counter <= counter - 1;
                    result <= {a_value, counter};
                    
                end
                else begin
                    next_state <= 2'b10;
                end
            end
            2'b10: begin
                finished <= 1;
                next_state <= 2'b00;
            end
        endcase
        current_state <= next_state;
    end

endmodule