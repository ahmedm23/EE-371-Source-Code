module firstGate (clk, reset, gate1_sw, water_high, water_low, arr_li, exited, gate1_li, occupied);
   input clk, reset, gate1_sw, arr_li, exited, water_high, water_low;

   output reg gate1_li, occupied;

   enum { A, B, C} ps, ns;

   always_comb
      case(ps)
         A: if (water_high == 1 && arr_li == 1 && gate1_sw == 1) // if the two conditions are met and gate switch is high
               ns = B; 
            else
               ns = A;
         B: if (gate1_sw == 0)
               ns = C;
            else
               ns = B;   
         C: if (exited == 1) 
               ns = A;
            else
               ns = C;   
      endcase

      assign gate1_li = (ps == B); 
      assign occupied = (ps == C);

   always_ff @(posedge clk)
      begin
         if (reset)
            ps <= A;
         else
            ps <= ns;
      end
endmodule

module firstGateTestBench ();
   
   logic clk, reset, gate1_sw, arr_li, exited, water_level;

   logic gate1_li, occupied;

   firstGate test (clk, reset, gate1_sw, water_level, arr_li, exited, gate1_li, occupied);
   
   parameter clk_PERIOD=100;
   initial begin
      clk <= 0;
      forever #(clk_PERIOD/2) clk <= ~clk;
   end


   initial begin
                                                   @(posedge clk);
   reset <= 1;                                     @(posedge clk);
   reset <= 0; arr_li = 0; water_level = 0; 
   gate1_sw = 0; exited = 0;                       @(posedge clk);
                                                   @(posedge clk);
               arr_li = 1; gate1_sw = 1;           @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
               water_level = 1;                    @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
                                                   @(posedge clk);
               gate1_sw = 0;                       @(posedge clk);
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
               exited = 1;                         @(posedge clk);
                                                   @(posedge clk);
   //$stop; // End the simulation.
   end
endmodule