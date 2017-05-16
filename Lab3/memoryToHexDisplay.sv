module memoryToHexDisplay(hex_count, mem_used);
   	input  signed [7:0] mem_used;
   	output reg [6:0] hex_count;
	reg [7:0] mem_divided;
	
	assign mem_divided = (mem_used * 205) >> 11;	
	
	always_comb
		case (mem_divided)
			// Light: 6543210
			8'b00000000: hex_count = ~7'b0111111; // 0
			8'b00000001: hex_count = ~7'b0000110; // 1
			8'b00000010: hex_count = ~7'b1011011; // 2
			8'b00000011: hex_count = ~7'b1001111; // 3
			8'b00000100: hex_count = ~7'b1100110; // 4
			8'b00000101: hex_count = ~7'b1101101; // 5
			8'b00000110: hex_count = ~7'b1111101; // 6
			8'b00000111: hex_count = ~7'b0000111; // 7
			8'b00001000: hex_count = ~7'b1111111; // 8
			8'b00001001: hex_count = ~7'b1101111; // 9
			8'b00001010: hex_count = ~7'b1000000; // -
			default: hex_count = ~7'bX;
		endcase
endmodule

module memoryToHexDisplay_testbench();
	logic [7:0] mem_used;
	logic [6:0] hex_count;
	
	memoryToHexDisplay dut (hex_count, mem_used);
	
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i <= 100; i++) begin
			mem_used = i;
			#10;
		end
	end
endmodule


