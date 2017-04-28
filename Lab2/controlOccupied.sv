module controlOccupied (status, clk, reset, flag);
	input status, clk, reset;
	output flag;   
	enum { A, B } ps, ns;
  
	always_comb 
		case (ps)
			A: if (status)  ns = B;
		      else         ns = A;	
			B: if (~status) ns = A;
		      else         ns = B;	
		endcase 
  
  assign flag = (ps == B);
  
	always_ff @(posedge clk)
	begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end
endmodule  
  
module controlOccupied_testbench();
	logic status, clk, reset;
	logic flag;
	
	controlOccupied dut (status, clk, reset, flag);
	
	// Set up the clk.
	parameter clk_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(clk_PERIOD/2) clk <= ~clk;
	end
	// Set up the inputs to the design. Each line is a clk cycle.
	
	// If light is on, 
	initial begin
																	@(posedge clk);
	reset <= 1; 												@(posedge clk);
	reset <= 0; status = 0; 	@(posedge clk);
																	@(posedge clk);
					status = 1;		@(posedge clk);
																	@(posedge clk);
																	@(posedge clk);
					status = 0;		@(posedge clk);
																	@(posedge clk);

	//$stop; // End the simulation.
	end
endmodule