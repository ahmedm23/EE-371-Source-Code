module controlScanner(clk, reset, hex_state_s1, hex_count_s1, hex_state_s2, hex_count_s2, rdy_flush, flush); 
	output logic [6:0] hex_state_s1, hex_count_s1, hex_state_s2, hex_count_s2;
	output logic rdy_flush;
	input logic clk, reset, flush;  
	
    logic [7:0] mem_used_s1, mem_used_s2;
	logic [3:0] state_s1, state_s2;
	
	// inputs current memory output from primScanner and altScanner
	// outputs respective count HEX LEDs	
	memoryToHexDisplay m1 (.reset, .hex_count(hex_count_s1), .mem_used(mem_used_s1));
	memoryToHexDisplay m2 (.reset, .hex_count(hex_count_s2), .mem_used(mem_used_s2));

	// inputs state 3 bit number from primScanner and altScanner
	// outputs respective state HEX LEDs
	stateToHex s1 (.state(state_s1), .hex_state);
	stateToHex s2 (.state(state_s2), .hex_state);
	
	logic scan_status, 
		  start_scan_out,
		  goto_stby_out,		  
		  start_scan_in, 
		  goto_stby_in; 
		  
    logic [7:0] alt_mem_used;
	primScanner ps (.clk, .reset, .scan_status, .rdy_flush, .start_scan_out,
					.goto_stby_out(goto_stby_in), .mem_used(mem_used_s1), .state(state_s1), 
					.start_scan_in(start_scan_out), .goto_stby_in, .flush, .alt_mem_used(mem_used_s2));
					
	altScanner  as (.clk, .reset, .scan_status, .rdy_flush, .start_scan_out,
				    .goto_stby_out(goto_stby_in), .mem_used(mem_used_s2), .state(state_s2), 
					.start_scan_in(start_scan_out), .goto_stby_in, .flush, .alt_mem_used(mem_used_s1));
endmodule

