module controlScanner(clk, reset, hex_state1, hex_count1, hex_state2, hex_count2, rdy_flush, flush); 
	output logic [6:0] hex_state1, hex_count1, hex_state2, hex_count2;
	output logic rdy_flush;
	input logic clk, reset, flush;  
	
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
		   rdy_flush1,
		   rdy_flush2;
	
	// temporarily fixes the fan out issue with rdy_flush, cannot be assigned more than one value
   assign rdy_flush = rdy_flush1 || rdy_flush2;	
		  
	primScanner ps (.clk, .reset, 
						 .rdy_flush(rdy_flush1), 
						 .start_scan_out(start_scan_out1),
					    .goto_stby_out(goto_stby_out1), 
						 .mem_used(mem_used1), 
						 .state(state1), 
						 .start_scan_in(start_scan_out2), 
						 .goto_stby_in(goto_stby_out2), 
						 .flush, 
						 .alt_mem_used(mem_used2)
						 );
					
	altScanner as (.clk, .reset, 
						.rdy_flush(rdy_flush2), 
						.start_scan_out(start_scan_out2),
						.goto_stby_out(goto_stby_out2), 
						.mem_used(mem_used2), 
						.state(state2), 
						.start_scan_in(start_scan_out1), 
						.goto_stby_in(goto_stby_out1), 
						.flush, 
						.alt_mem_used(mem_used1));
   /*					
   logic scan_status, 
		  start_scan_out,
		  goto_stby_out,		  
		  start_scan_in, 
		  goto_stby_in; 
		  
   logic [7:0] alt_mem_used;
	primScanner ps (.clk, .reset, .scan_status, .rdy_flush, .start_scan_out,
					.goto_stby_out(goto_stby_in), .mem_used(mem_used1), .state(state1), 
					.start_scan_in(start_scan_out), .goto_stby_in, .flush, .alt_mem_used(mem_used2));
					
	altScanner  as (.clk, .reset, .scan_status, .rdy_flush, .start_scan_out,
				    .goto_stby_out(goto_stby_in), .mem_used(mem_used2), .state(state2), 
					.start_scan_in(start_scan_out), .goto_stby_in, .flush, .alt_mem_used(mem_used1));
	*/				
endmodule



