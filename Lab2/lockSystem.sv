module lockSystem (clk, reset);
	input clk, reset;
	enum { A, B, C, D, E, F } ps, ns;
	/*
	A: Both Locked and Unoccupied
	B: Both Locked and Unoccupied Boat coming from L 
	C: Both Locked and Unoccupied Boat coming from R
	D: Gate L Unlocked
	E: Gate R Unlocked
	F: Both Locked and Occupied
	*/
	
	always_comb 
		case (ps)
			A: //if boat signals from L side and water level > 4.7, go to state B 
				//else if boat signals from R side and water level < 0.3, go to state C 
	
	
	
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
