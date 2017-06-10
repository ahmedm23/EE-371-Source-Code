//module create_sequence(clk, reset, data, pressed, didDie);
//	input logic clk, reset;
//	input logic [1:0] data;
//	input logic [3:0] pressed;
//	output logic didDie;
//
//	logic        [2:0] ps, ns;
//	
//	parameter
//	red    = 2'b00, 
//	green  = 2'b01, 
//	blue   = 2'b10, 
//	yellow = 2'b11;
//	
//	always_comb 
//		case(something)
//		
//		A: if (data) 					  ns = B;
//			else 		 					  ns = A;
//		B: if (key is pressed) 		  ns = C; 
//			else 					  		  ns = B;
//			
//		C: if (wrong key is pressed) ns = D;
//			else							  ns = A;	
//		D: ns = A;
//		
//		didDie = ps == D;
//		
//		endcase
//
//endmodule





//module sequence_generator (
//	input clk,
//	input randomize,
//	input next,
//	input start_over,
//	output [3:0] seq
//);
//	reg [17:0] counter = 18'b100110101011010111;
//	reg [17:0] seed;
//	reg [17:0] current;
//	
//	assign seq = 4'b1 << current[1:0];
//	
//	always @(posedge clk) begin
//		counter <= {counter[15:0], counter[17:16] ^ counter[10:9]};
//		if (randomize)
//			seed <= counter;
//		if (start_over)
//			current <= seed;
//		else if (next)
//			current <= {current[15:0], current[17:16] ^ current[10:9]};
//	end
//endmodule
