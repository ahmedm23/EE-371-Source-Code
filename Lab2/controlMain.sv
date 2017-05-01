module controlMain(clk, reset, arr_sw, dep_sw, gate1_sw, gate2_sw, w_up, w_down);
//  Arrival Switch SW0 -- Arrival Light LEDR0
//  Depart  Switch SW1 -- Depart Light  LEDR1
//  1stGate Switch Sw2 -- 1stGate Light LEDR2  
//  2ndGate Switch Sw3 -- 2ndGate Light LEDR3
//  Raise_Water KEY1
//  Lower_Water KEY2

//  reset KEY0
	
	arrival a (.clk, .reset,  

// Arrival Module that Ahmed will do 
Input: Clk, reset, SW0 
Output: LEDR0, (count of timer)
	if SW = 1
	After 5 min delay 
	Turn on LEDR0
	
	
	
// Waterlevel Module
Input: clk, reset, KEY1, KEY2
Logic: Waterlevel
Output: Waterlevel [5:0] 
	Takes in key presses and adjusts water level accordingly

	
// Allow Boat to Enter 1st Gate Module
Input: clk, reset, SW2, Waterlevel, LEDR0, exited
Output: LEDR2, Occupied
	A: if waterlevel > 47 && LEDR0 = 1 && SW2 = 1 // if the two conditions are met and gate switch is high
			Go to B  
		else
			Stay in A
	B: If SW2 is flipped down = 0
		Go to state C
	C: if exited = 1 
		Go to state A
	assign LEDR2 = (ps == B); 
	assign Occupied = (ps == C);
	
	
// Allow Boat to Exit 2nd Gate Module
Input: clk, reset, SW1, SW3, waterlevel, Occupied,  
Output: LEDR1, LEDR3, exited	
	A: if occupied and SW1 = 1
		go to B
	B: if waterlevel < 3 && SW3 = 1
		go to C
	C: if SW1 = 0 && SW3 = 0
		go to D
	D: go to state A
	assign LEDR1 = (SW1 == 1 && occupied); //Depart light one when depart switch is high and Lock is occupied
	assign LEDR3 = (ps == C);
	assign exited = (ps == D);


  
endmodule
