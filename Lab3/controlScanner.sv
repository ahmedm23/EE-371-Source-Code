module controlScanner(clk, reset, scanning, ready_trans, standby, hex_display, idle, scan, transfer, flush); 
    output logic scanning, ready_trans, standby, idle;
	output logic hex_display [6:0];
	input logic clk, reset, scan, transfer, flush;  
    logic mem_used [7:0];
	
	memory m (.clk, .reset, .mem_used, .scan, .transfer, .flush);
	memoryToHexDisplay(.reset, .hex_display, .mem_used);
	
	
endmodule

