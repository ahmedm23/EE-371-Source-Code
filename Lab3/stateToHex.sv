module stateToHex(hex_state, state); 
	output logic [6:0] hex_state;
    input logic [2:0] state;
	
	parameter
	low_power  = 3'b000, 
	standby    = 3'b001, 
	collecting = 3'b010, 
	idle 	     = 3'b011, 
	flushing   = 3'b100,
	xferring   = 3'b101;
	
	always_comb 
		case (state)
			low_power:  hex_state = 7'b1000111; // L
			standby:    hex_state = 7'b0010010; // S
			collecting: hex_state = 7'b1000110; // C
			idle:		   hex_state = 7'b1111001; // I
			flushing: 	hex_state = 7'b0001110; // F
			xferring: 	hex_state = 7'b0000111; // t
			default:	   hex_state = 7'b1111111; // off			
		endcase
endmodule

module stateToHex_testbench();
	logic [6:0] hex_state;
	logic [2:0] state;
	
	stateToHex dut (.hex_state, .state);
	
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i <= 7; i++) begin
			state = i;
			#10;
		end
	end
endmodule


