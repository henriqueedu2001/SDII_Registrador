iverilog -o adder_subtractor modules/adder_subtractor.v modules/negative.v testbenchs/test_adder_subtractor.v
vvp adder

iverilog -o neg modules/negative.v testbenchs/test_negative.v