module controlMain (clk, reset);  
	input clk, reset;
	logic status, occupied;
	
	logic [5:0] water_level;
	logic [2:0] water_status;
	
	logic [2:0] gate_state;
	
	// logic for status symbol and you gotta deal with it somewhere somehow
	// if boat is coming from the left and entering, or coming from the right and entering, status = 1;
	// if boat is exiting left or exiting right, status = 0;
	
	
	controlOccupied (clk, reset, .status, occupied);
	
	
	controlWater(clk, reset, water_level, water_status);
	
	
	controlGate(clk, reset, upper_switch, lower_switch, gate_state, water_status, occupied);  
  
endmodule
