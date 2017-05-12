module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  CLOCK_50; // 50MHz clock.
	input  [3:0] KEY; // True when not pressed, False when pressed
	input  [9:0] SW;
	output  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output  [9:0] LEDR;
   
	// Clock divider
	// tBase[0] == 50MHz
	// tBase[1] == 25MHz
	// tBase[2] == 12.5MHz
	reg [25:0] tBase;
	always@(posedge CLOCK_50) tBase <= tBase + 1'b1;  
	
	/* FOR SCANNER  ---------------------
	clk 							tBase[parameter]
	reset 							KEY[0]
    hex_state_s1					HEX5
	hex_count_s1 					HEX4
	hex_state_s2					HEX1
	hex_count_s2 					HEX0
	flush 							SW[9]
	
	The hex_states display what state each scanner is in, 
	and the hex_count displays the percentage of the buffer for each scanner
	*/
	controlScanner cs (.clk(tBase[23]), .reset(~KEY[0]), .hex_state_s1(HEX5), 
					   .hex_count_s1(HEX4), .hex_state_s2(HEX1), .hex_count_s2(HEX0), 
					   .flush(SW[9]));
	
endmodule





