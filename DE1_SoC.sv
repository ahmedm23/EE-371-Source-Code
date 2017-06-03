// Implements a simple Nios II system for the DE-series board.
// Inputs: SW7−0 are parallel port inputs to the Nios II system
// CLOCK_50 is the system clock
// KEY0 is the active-low system reset
// Outputs: LEDR7−0 are parallel port outputs from the Nios II system
module DE1_SoC (CLOCK_50, SW, KEY, LEDR, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
   input CLOCK_50;
   input [7:0] SW;
   input [0:0] KEY;
	output [7:0] VGA_R;
	output [7:0] VGA_G;
	output [7:0] VGA_B;
	output VGA_BLANK_N;
	output VGA_CLK;
	output VGA_HS;
	output VGA_SYNC_N;
	output VGA_VS;
   output [7:0] LEDR;
   
	reg [25:0] tBase;
	always@(posedge CLOCK_50) tBase <= tBase + 1'b1;
	
// Instantiate the Nios II system module generated by the Qsys tool:
   /*nios_system NiosII (
      .clk_clk(CLOCK_50),
      .reset_reset_n(KEY),
      .switches_export(SW),
      .leds_export(LEDR)); */
		
		// map one of the GPIOs coming out of the processor, set the speed of that in the CPU 
		// map an 8 bit register to each switch value
		// set a start signal from your processor to say hey let's go
  	
	logic [9:0] x;
	logic [8:0] y;
	logic [7:0] r, g, b;
	logic [32:0] count;

	always_ff @ (posedge CLOCK_50) begin
		count <= count + 1;
		if (count[24])
			if (x > 300 && x < 500 && y > 400 && y < 600) begin 
				r <= 8'd0;
				g <= 8'd0;
				b <= 8'd255; end
			else if (x > 0 && x < 200 && y > 0 && y < 200) begin 
				r <= 8'd155;
				g <= 8'd10;
				b <= 8'd255; end
			else if (x > 400 && x < 600 && y > 200 && y < 400) begin 
				r <= 8'd90;
				g <= 8'd0;
				b <= 8'd10; end
			else begin
				r <= 8'd0;
				g <= 8'd0;
				b <= 8'd0; end	
		else begin
			r <= 8'd0;
			g <= 8'd0;
			b <= 8'd0; end	
	end
	
	video_driver vid(.CLOCK_50, .reset(SW[7]), .x, .y, .r, .g, .b, .VGA_R, .VGA_G, .VGA_B, .VGA_BLANK_N, .VGA_CLK, .VGA_HS, .VGA_SYNC_N, .VGA_VS);
	
endmodule
