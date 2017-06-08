module lives_to_hex(clk, reset, did_die, hex_count, hex_sign);
   	input  clk, reset, did_die;
   	output reg [6:0] hex_count, hex_sign;
	reg [4:0] count;
	
	always_comb
		case (count)
			// Light: 6543210
			4'b0000: begin
				hex_count = ~7'b1011011; // 2
				hex_sign = ~7'b0000000; // + 
			end 
			4'b0001: begin 
				hex_count = ~7'b0000110; // 1
				hex_sign = ~7'b0000000; // +
			end
			8'b0010: begin
				hex_count = ~7'b0111111; // 0
			end
			4'b0011: begin
				hex_count = ~7'b0000110; // 1
				hex_sign = ~7'b1000000; // -
			end
			4'b0100: begin 
				hex_count = ~7'b1011011; // 2 
				hex_sign = ~7'b1000000; // -
			end
			4'b0101: begin 
				hex_count = ~7'b1001111; // 3
				hex_sign = ~7'b1000000; // -
			end
			4'b0110: begin
				hex_count = ~7'b1100110; // 4
				hex_sign = ~7'b1000000; // -
			end	
			4'b0111: begin
				hex_count = ~7'b1101101; // 5
				hex_sign = ~7'b1000000; // -
			end
			4'b1000: begin
				hex_count = ~7'b1111101; // 6
				hex_sign = ~7'b1000000; // -
			end
			8'b1001: begin
				hex_count = ~7'b0000111; // 7
				hex_sign = ~7'b1000000; // - 
			end
			4'b1010: begin
				hex_count = ~7'b1111111; // 8
				hex_sign = ~7'b1000000; // -
			end
			default: begin 
				hex_count = ~7'bX;
				hex_sign = ~7'bX;
			end
		endcase

		// DFFs
   always_ff @(posedge clk)
   begin
      if (reset | count > 10)
      	count   <= 4'b0000;
      else if (did_die)
        count <= count + 4'b0001;
      else 
      	count <= count;
   end
endmodule

module lives_to_hex_testbench();
	logic clk, reset, did_die;
	logic [6:0] hex_count, hex_sign;
	
	lives_to_hex dut (clk, reset, did_die, hex_count, hex_sign);
	
	parameter clk_PERIOD=50;
   	initial begin
    	clk <= 0;
      	forever #(clk_PERIOD) clk <= ~clk;
   	end


   initial begin
                                                   @(posedge clk);
   reset <= 1;                                     @(posedge clk);
   reset <= 0; did_die = 0;                         @(posedge clk);
                                                   @(posedge clk);
               did_die = 1;                         @(posedge clk);
                                                   @(posedge clk);
                did_die = 0;                        @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                             did_die = 1;           @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                             did_die = 0;           @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                            did_die = 1;            @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);

   //$stop; // End the simulation.
   end
endmodule


