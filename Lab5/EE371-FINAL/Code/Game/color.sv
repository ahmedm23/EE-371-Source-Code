module color (data, r, g, b);
	input logic [2:0] data;
	output logic [7:0] r, g, b;
	
	parameter
	empty  = 3'b000,
	red    = 3'b001, 
	green  = 3'b010, 
	blue   = 3'b011, 
	yellow = 3'b100;
	
	always_comb
		case(data)
			empty:   begin r = 8'b0;   g = 8'b0;	b = 8'b0;	end 
			red:     begin r = 8'd255; g = 8'd0;   b = 8'd0; 	end     
			green:   begin r = 8'd0;   g = 8'd255; b = 8'd0; 	end  
			blue:    begin r = 8'd0;   g = 8'd0;   b = 8'd255; end  
			yellow:  begin r = 8'd255; g = 8'd255; b = 8'd0;	end
			default:	begin r = 8'b0;   g = 8'b0;	b = 8'b0;	end 	
		endcase

endmodule 

module color_testbench();
	logic [2:0] data;
	logic [7:0] r, g, b;
	
	color dut (.data, .r, .g, .b);
	
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i <= 5; i++) begin
			data = i;
			#10;
		end
	end
endmodule