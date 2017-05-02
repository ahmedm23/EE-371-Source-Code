// Allow Boat to Exit 2nd Gate Module
module secondGate (clk, reset, dep_sw, gate2_sw, water_high, water_low, occupied, 
                   dep_li, gate2_li, exited);
	input clk, reset, dep_sw, gate2_sw, water_high, water_low, occupied;
   output dep_li, gate2_li, exited; 
   
	enum { A, B, C, D} ps, ns;
   
   always_comb
      case(ps)
         A: if (occupied & dep_sw)           ns = B;
            else                             ns = B;
         B: if (water_low & gate2_sw)        ns = C;
            else                             ns = B;
         C: if (~dep_sw & ~gate2_sw)         ns = D;
            else                             ns = C;
         D:                                  ns = A;
      endcase
   assign dep_li   = (dep_sw & occupied); //Depart light one when depart switch is high and Lock is occupied
   assign gate2_li = (ps == C);
   assign exited   = (ps == D);
   
//Input: clk, reset, SW1, SW3, waterlevel, Occupied,  
//Output: LEDR1, LEDR3, exited  
//   A: if occupied and SW1 = 1
//      go to B
//   B: if waterlevel < 3 && SW3 = 1
//      go to C
//   C: if SW1 = 0 && SW3 = 0
//      go to D
//   D: go to state A

   always @(posedge clk)
	begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end
   
endmodule

module secondGateTestBench();
   logic clk, reset, dep_sw, gate2_sw, water_high, water_low, occupied;
   logic dep_li, gate2_li, exited;
   
   secondGate test (.clk, .reset, .dep_sw, .gate2_sw, .water_high, .water_low, .occupied, .dep_li, .gate2_li, .exited);
   
   parameter clk_PERIOD=50;
   initial begin
      clk <= 0;
      forever #(clk_PERIOD) clk <= ~clk;
   end

   initial begin
                                                   @(posedge clk);
   reset <= 1;                                     @(posedge clk);
   reset <= 0; occupied <= 0; dep_sw <= 0;                         @(posedge clk);
                                                   @(posedge clk);
                                       @(posedge clk);
               occupied <= 1;                                    @(posedge clk);
                                                   @(posedge clk);
               dep_sw <= 1;                                    @(posedge clk);
                                                   @(posedge clk);
               water_low = 0;                                    @(posedge clk);
               water_low <= 1; gate2_sw <= 1;                                     @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
               gate2_sw <= 0; dep_sw <= 0;                                     @(posedge clk);
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
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);

   //$stop; // End the simulation.
   end
endmodule
