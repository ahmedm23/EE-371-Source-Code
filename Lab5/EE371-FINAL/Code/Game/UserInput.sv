module UserInput (clk, keys, pressed);
	input logic clk;
	input logic keys;
	output logic pressed;
	
	// You want to design a simple FSM that
	//	detects the moment the button is pressed – 
	//	its output is TRUE for only 1 cycle for every
	//	button press. This will handle all user input.
	logic key1, key_d, key_clean;
   assign pressed = key_clean & !key_d;
	
	always @ (posedge clk) begin
		key1 <= keys;
		key_clean <= key1;
		key_d <= key_clean;
	end
	
endmodule

module UserInput_testbench();
	logic clk;
	logic keys;
	logic pressed;
	
	UserInput dut (.clk, .keys, .pressed);

	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
									 @(posedge clk);
	keys <= 0; 				 @(posedge clk);
									 @(posedge clk);
	keys <= 1; 				 @(posedge clk);
									 @(posedge clk);
									 @(posedge clk);
									 @(posedge clk);
									 @(posedge clk);
									 
	keys <= 0;
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
	end
endmodule