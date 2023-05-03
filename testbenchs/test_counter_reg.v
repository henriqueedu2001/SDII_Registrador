module test_counter_reg
    reg clk; 
    reg reset; 
    wire [3:0] cr_data_output;

    // instância da Unit Under Test
	counter uut(
		.clk(clk),
		.reset(reset),
        .cr_data_output(cr_data_output));

    initial begin 

        clk = 0;
        reset = 1;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 1;
        reset = 1;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 0;
        reset = 1;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 1;
        reset = 0;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 0;
        reset = 0;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 1;
        reset = 0;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 0;
        reset = 0;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 1;
        reset = 0;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 0;
        reset = 1;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

        clk = 1;
        reset = 1;
		$monitor ("clk = %B; reset = %B; out: %B", clk, reser, cr_data_output);
		#100;

    end
endmodule