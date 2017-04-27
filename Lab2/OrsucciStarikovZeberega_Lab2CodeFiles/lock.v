`timescale 1ns/1ns
module lock (Clock, Reset, upperSwitch, lowerSwitch, upperGate, lowerGate, waterUp, waterDown, arriving, departing, occupied);
	input Clock, Reset, arriving, departing, upperSwitch, lowerSwitch, waterUp, waterDown;
	// these registers control the upper and lower gates of the lock
	output reg upperGate, lowerGate;
    // This wire will connect to the occupied indicator.
	output wire occupied;  
	// These registers are the controls for the water level
	reg raiseWater, lowerWater;
	// This is the wire to connect to the fakeWaterSensor module
	wire [5:0] waterLevel;
    // These registers store whether or not an arriving/departing gondola has made it into the lock.
	reg arrived, departed;
    // If a gondola has made it into the lock then indicate that the lock is occupied.
	assign occupied = arrived | departed;

	// This module is a fakeWaterSensor and also controls the waterLevel. For a real world implementation this module 
	// wouldn't be necessary. waterSensor data would be read from a physical sensor in the lock and the waterLevel controls
	// would cause the lock to fill or drain.
	water_level fakeWaterSensor (Clock, Reset, raiseWater, lowerWater, waterLevel);
	// These two registers store the current and next state of the FSM
	reg [2:0] ps, ns;

	// Next state logic
	always @* begin
		case(ps)
			3'b000: begin // Both Gates Locked and Empty
				// Check to see if the waterlevel has reached a level high or low enough to allow one of the gates to be unlocked.
				// We are assuming that the high water level is 5.0 feet and that the gate should be allowed to open when it is within
				// 0.3 feet of the water level on the other side of the gate, or 4.7 feet.
				if (waterLevel >= 47)
					ns = 3'b010;
				// Do the same check except for the lower level gate. We are assuming that the water level on the other side of the 
				// lower level gate is 0.0 feet. The water level has to be 0.3 feet or less to open the gate.
				else if (waterLevel <= 3)
					ns = 3'b001;
                // If there is an incoming arrival then switch to that state
				else if (arriving)
					ns = 3'b100;
				// If there is an incoming departure, then switch to that state.
                else if (departing)
					ns = 3'b110;
                // Otherwise stay in the same state.
				else 
					ns = 3'b000;
				// Within the Both Gates Locked State both the upper and lower gates are locked
				upperGate = 0;
				lowerGate = 0;
                
                // The water level is now controllable by the operator
				lowerWater = waterDown;
				raiseWater = waterUp;

                // If we get into this state then we want to make sure that the occupied light isn't on.
                arrived = 0;
                departed = 0;
			end
			  
			3'b100: begin // Locked, Empty, and incoming Arrival
				// If the water level is low enought then unlock the lower gate
                if (waterLevel <= 3)
					ns = 3'b001;
				else 
					ns = 3'b100;
                // Since there's an incoming arrival we need to drain water from the lock.
				lowerWater = 1;
				raiseWater = 0;
			end

			3'b110: begin // Locked, Empty, and incoming Departure
                // If the water level is high enough then unlock the upper gate.
				if (waterLevel >= 47)
					ns = 3'b010;
				else
					ns = 3'b110;
					
				lowerWater = 0;
                // Since there is an incoming Departure fill the lock with water to raise the water level.
				raiseWater = 1;
			end

			3'b111: begin // Locked and Occupied
				if (waterLevel >=47 & arrived)
                    // If the water level is high enough then unlock the upper gate
					ns = 3'b010;
				else if (waterLevel <= 3 & departed)
                    // If the water level is low enough then unlock the lower gate.
					ns = 3'b001;
				else
					ns = 3'b111;

				lowerWater = waterDown;
				raiseWater = waterUp;
			end

			3'b010: begin // Upper Gate unlocked
				// Switch back to the Locked State if the water level drops below 4.7 feet.
				if (waterLevel < 47) begin
				// If a vessel currently occupies the lock then switch to the Locked and Occupied state
					if (occupied)
						ns = 3'b111;
				  // Otherwise switch to the locked and unoccupied state.
					else
						ns = 3'b000;
				end
				// Otherwise stay in the unlocked state.
				else                                            
					ns = 3'b010;

				// Within this state the Upper gate is unlocked, meaning the gate control signal from the operator is allowed to 
				// pass to the door.
				upperGate = upperSwitch;

				// If the lock is occupied from an incoming 
				if (upperGate & arrived)
					arrived = 0;
				else if (upperGate & departing)
					departed = 1;
				// Check if the upper gate is closed. If so then allow the water level to be controlled.
				if (~upperGate) begin
					lowerWater = waterDown;
					raiseWater = waterUp;
				end
				else begin // Otherwise disable the water level control.
					lowerWater = 0;
					raiseWater = 0;
				end
			end

			3'b001: begin // Lower Gate unlocked
				// Switch back to the Locked State if the water level rises above 0.3 feet.
				if (waterLevel > 3) begin
					// Switch to the locked and occupied state if occupied.
					if (occupied)
						ns = 3'b111;
					// Otherwise switch to locked and unoccupied state
					else
						ns = 3'b000;
				end
				//Otherwise stay in the unlocked state
				else
					ns = 3'b001;
				
				// Within this state the lower gate is unlocked. 
				lowerGate = lowerSwitch; 
				if (lowerGate & departed)
					departed = 0;
				else if (lowerGate & arriving)
					arrived = 1;

				if (~lowerGate) begin // If the lower gate is closed, then allow the water to be controlled.
					lowerWater = waterDown;
					raiseWater = waterUp;
				end
				else begin // Otherwise the water level control is disabled.
					lowerWater = 0;
					raiseWater = 0;
				end
			end
		endcase 
	end
	// DFFs
	always @(posedge Clock or negedge Reset) 
	begin
		// Reset to the sealed state in case of the Reset Button
		if ( ~Reset  )
			ps <= 3'b00;
		// Otherwise move to the next state.
		else
			ps <= ns;
	end
endmodule

module water_level(Clock, Reset, raiseWater, lowerWater, waterLevel);
	input Clock, Reset, raiseWater, lowerWater;
	// This register stores the waterLevel as a 6-bit number between 0 and 50
	output reg [5:0] waterLevel;
	wire clk;
	// 23 bits is enough to store a number greater than 5,000,000. that number would allow
	// us to make a 10Hz clock using the 50Mhz clock on the DE1. 
	reg [22:0] delay;
	always @(*)
    begin    
        if( lowerWater )
            // The differences in delays are to simulate the different speeds at which water fills/drains from the lock
            delay = 4; 
        else
            delay = 6;
    end
	// Use a clock divider to make a clock to emulate the speed at which water will fill and drain from the lock.
	clock_divider WATERCLOCK (Clock, Reset, delay, clk);

	// Use a DFF to implement the waterLevel
	always @(posedge clk or negedge Reset)
	begin
		// If Reset turns on then reset the waterlevel to right in the middle.
		if ( ~Reset )
			waterLevel <= 25;
		// If the signal to lower the water level is on and the the lock isn't empty then lower the water level.
        else if (lowerWater & (waterLevel != 0))
            waterLevel <= waterLevel - 6'b1;
        // Otherwise if the signal to raise the water level from the lock system is enabled and the lock isn't full 
		// add more water
        else if (raiseWater & (waterLevel != 50))
            waterLevel <= waterLevel + 6'b1;
	end
endmodule

// This is a clock divider.
module clock_divider (Clock, Reset, delay, outputClock);
	input Clock, Reset;
	input [22:0] delay;
	reg [22:0] dividedClocks;
	output reg outputClock;

	always @(posedge Clock or negedge Reset) begin
		if ( ~Reset )
			dividedClocks <= 0;
		else begin
			dividedClocks <= dividedClocks + 22'b1;
			if (dividedClocks == delay/2)
				outputClock <= 1;
			else if (dividedClocks >= delay) begin
				outputClock <= 0;
				dividedClocks <= 0;
			end 
		end
	end
endmodule

// TestBench for the lock
module lock_testbench();
	reg Clock, Reset, upperSwitch, lowerSwitch, waterUp, waterDown, arriving, departing;
	wire upperGate, lowerGate, occupied;

	lock LOCKTEST (Clock, Reset, upperSwitch, lowerSwitch, upperGate, lowerGate, waterUp, waterDown, arriving, departing, occupied);

	parameter PERIOD = 2; // period = length of clock                      
						// Make the clock LONG to test
	initial begin
		$dumpfile("LockTester.vcd");
		$dumpvars;   
		Clock <= 0;   
		forever #(PERIOD/2) Clock = ~Clock; 
	end 
	
	initial begin
        departing = 0;
        upperSwitch = 0;
		lowerSwitch = 0;
		waterUp = 0;
		waterDown = 0;
		Reset = 0;
		@(posedge Clock);
		Reset = 1;
		@(posedge Clock); 
		#10;
		arriving = 1; #175;
		lowerSwitch = 1; #10;
		lowerSwitch = 0; #10;
		waterUp = 1; #200;
		waterUp = 0; #25
		lowerSwitch = 1; #10;
		lowerSwitch = 0; #10;
	    arriving = 0; #10;	
        upperSwitch = 1; #10;
		upperSwitch = 0; #10;
		upperSwitch = 1;
		lowerSwitch = 1; #10;
		upperSwitch = 0; #10;
		lowerSwitch = 0;
		waterDown = 1; #130; waterDown = 0;
		lowerSwitch = 0; #10;
		upperSwitch = 1; #10;
		lowerSwitch = 1; #10;
		upperSwitch = 0; #10;
		lowerSwitch = 0; #10;
		waterUp = 1; #750; waterUp = 0;
        arriving = 0; departing = 0; #15; 
        upperSwitch = 1; #10; departing = 1; #5; upperSwitch = 0;
		lowerSwitch = 1; #10; lowerSwitch = 0;
        departing = 0; arriving = 0;
        waterDown = 1; #525;
        lowerSwitch = 1; #25; lowerSwitch = 0; #25;
        waterDown = 0;
        waterUp = 1; #100;
		Reset = 1; #10;
		Reset = 0; #10;  
		$stop();
	end
endmodule 
