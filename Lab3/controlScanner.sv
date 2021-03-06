module controlScanner(clk, reset, hex_state1, hex_count1, hex_state2, hex_count2, rdy_xfer, xfer); 
	output logic [6:0] hex_state1, hex_count1, hex_state2, hex_count2;
	output logic rdy_xfer;
	input logic clk, reset, xfer;  
	
   logic [7:0] mem_used1, mem_used2;
	logic [2:0] state1, state2;
	
	// inputs current memory output from primScanner and altScanner
	// outputs respective count HEX LEDs	
	memoryToHexDisplay m1 (.hex_count(hex_count1), .mem_used(mem_used1));
	memoryToHexDisplay m2 (.hex_count(hex_count2), .mem_used(mem_used2));

	// inputs state 3 bit number from primScanner and altScanner
	// outputs respective state HEX LEDs
	stateToHex s1 (.state(state1), .hex_state(hex_state1));
	stateToHex s2 (.state(state2), .hex_state(hex_state2));
	
	logic start_scan_out1,
			start_scan_out2,
		   goto_stby_out1,
         goto_stby_out2,
		   rdy_xfer1,
		   rdy_xfer2;
	
	// turns on rdy_xfer light if either scanner reaches 80% buffered
   assign rdy_xfer = rdy_xfer1 || rdy_xfer2;	
	
	// instantiates first scanner
	primScanner ps (.clk, .reset, 
						 .rdy_xfer1, 
						 .start_scan_out1,
					    .goto_stby_out1, 
						 .mem_used1, 
						 .state1, 
						 .start_scan_in(start_scan_out2), 
						 .goto_stby_in(goto_stby_out2), 
						 .xfer, 
						 .alt_mem_used(mem_used2)
						 );
	
	// instantiates second scanner	
	altScanner as (.clk, .reset, 
						.rdy_xfer2, 
						.start_scan_out2,
						.goto_stby_out2, 
						.mem_used2, 
						.state2, 
						.start_scan_in(start_scan_out1), 
						.goto_stby_in(goto_stby_out1), 
						.xfer, 
						.alt_mem_used(mem_used1)
						);
		
endmodule



