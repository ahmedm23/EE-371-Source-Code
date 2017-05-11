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
	
	/* FOR SCANNER 1 ---------------------
	clk 							tBase[parameter]
	reset 							KEY[0]
	
	scanning_s1 					LEDR[9]
	ready_trans_s1 					LEDR[8]
	standby_s1 						LEDR[7]
	idle_s1 						LEDR[6]
	hex_display_s1 					HEX5
	
	transfer 
	
	FOR SCANNER 2 -------------------------
	clk tBase[parameter]
	reset KEY[0]
	
	scanning_s2 					LEDR[4]
	ready_trans_s2					LEDR[3]
	standby_s2						LEDR[2]
	idle_s2							LEDR[1]
	hex_display_s2 					HEX0
	
	transfer
	*/
	
endmodule





