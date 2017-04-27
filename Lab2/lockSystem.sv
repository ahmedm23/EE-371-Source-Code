module lockSystem (clk, reset, highSig, lowSig);
	input clk, reset, highSig, lowSig;
	enum { A, B, C, D, E, F } ps, ns;
	/*
	A: Both Locked and Unoccupied
	B: Both Locked and Unoccupied, Boat coming from H 
	C: Both Locked and Unoccupied, Boat coming from L
	D: Gate H Unlocked
	E: Gate L Unlocked
	F: Both Locked and Occupied
	*/
	
	/*
	A: Unoccupied and Closed
	B: Unoccupied and Open
	C: Occupied   and Open
	D: Occupied   and Closed
	*/
	// in terms of the gate, considers if theres a boat in there
	// consider if we can open the gate or not
	// what are the conditions for when to open the gate?
	// water level; if it's occupied
	// these two conditions: our state diagram becomes either 4 or 5, might be even less (maybe)
	// occupied and open, occupied closed, unoccupied open, unoccupied closed
	// moving our state based on waterlevel 
	// break the state diagram down to the simplest system we can consider
	// state diagram that is the same coming from both ways

	always_comb 
		case (ps)
			A: // go to B (opening the gate and letting the ship through)
            if (highSig | lowSig)
               ns = B;
            else
               ns = A;
			B: // go to C (ship is entering lock)
			   // go to A (with ship gone, close the gate)
            
		   C: // go to D (with ship inside, close the gate)
	         // go to B (ship left, unoccupied but still open) 		
		   D: // go to C (open the other gate)
	
	
	
		endcase
		
	// if you press Key0, resets to both locked and unoccupied
	always @(posedge clk)
	begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end
endmodule

