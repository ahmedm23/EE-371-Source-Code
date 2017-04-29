module controlMain (clk, reset, departing, arriving, upper_switch, lower_switch, water_level, gate_state, occupied);  
	input clk, reset, departing, arriving;
	input upper_switch, lower_switch;
	input [5:0] water_level;

	output [2:0] gate_state;
	output occupied;

	logic status;	
	logic [2:0] water_status;
	
//module that controls the inputs for arriving and departing and output upper switch and lower switch
// if the ship is arriving from the upper side, upper switch = 1, also has to be unoccupied
// if the ship is arriving fro mthe lower side, lower switch = 1, also has to be unoccupied


	
	// logic for status symbol and you gotta deal with it somewhere somehow
	// if boat is coming from the left and entering, or coming from the right and entering, status = 1;
	// if boat is exiting left or exiting right, status = 0;
	
	
	controlOccupied co (.clk, .reset, .status, .occupied);	
	controlWater    cw (.clk, .reset, .water_level, .water_status);	
	controlGate     cg (.clk, .reset, .upper_switch, .lower_switch, .gate_state, .water_status, .occupied);  
  
endmodule
