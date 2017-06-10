// Avoids metastability and outputs a pulse from a
// raw key press
module UserInput (clk, keys, pressed);
	input logic clk;
	input logic keys;
	output logic pressed;

	logic key1, key_d, key_clean;
   // creates a pulse
   assign pressed = key_clean & !key_d;
	
	always @ (posedge clk) begin
	    // avoids metastability
		key1 <= keys;
		key_clean <= key1;
		// adds a delay
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