
module controlWater (clk, reset, water_high, water_low, w_up, w_down);
   input  logic clk, reset;
   output logic water_high, water_low;
   input  logic w_up, w_down;

   logic [7:0] water_counter; // This counter for timing of raise/lower water

   enum {low, high, raise, lower} ps, ns;

   always_comb begin
      case (ps)
         low:   begin
                   if (w_up) ns = raise;
                   else      ns = low;
                end
         high:  begin
                   if (w_down) ns = lower;
                   else        ns = high;
                end
         raise: begin
                   if (water_counter < 8'd80) ns = raise;
                   else                       ns = high;
                end
         lower: begin
                   if (water_counter < 8'd70) ns = lower;
                   else                       ns = low;
                end
      endcase

      // Timing for water to go 0' -> 4.7'
      // Timing for water to go 5' -> 0.3'
      water_high = (water_counter > 8'd74) | ps == high;
      water_low = (water_counter > 8'd65 & ps == lower) | ps == low;
   end

   always_ff @ (posedge clk)
      if (reset) begin
         ps <= low; // What should be the default state?
         water_counter <= 8'd0;
      end
      else begin
         ps <= ns;
         if (ps == raise | ps == lower) water_counter <= water_counter + 8'd1;
         else                           water_counter <= 8'd0;
      end
endmodule

module controlWater_testbench ();
   logic clk, reset, w_up, w_down;
   logic water_high, water_low;

   controlWater dut (.clk, .reset, .water_high, .water_low, .w_up, .w_down);

   parameter CLK_PER = 10;
   initial begin
      clk <= 1;
      forever #(CLK_PER/2) clk <= ~clk;
   end

   integer i;
   initial begin
                                             @(posedge clk);
      reset <= 1; w_down <= 0; w_up <= 0;    @(posedge clk);
      reset <= 0;                            @(posedge clk);
                  w_down <= 1;               @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
                  w_down <= 0;               @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
                               w_up <= 1;    @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
                               w_up <= 0;    @(posedge clk);
                                             @(posedge clk);
                                             @(posedge clk);
      for (i = 0; i < 80; i++) begin
         @(posedge clk);
      end
                               w_up <= 1;    @(posedge clk);
                               w_up <= 0;    @(posedge clk);
                  w_down <= 1;               @(posedge clk);
                  w_down <= 0;               @(posedge clk);
      for (i = 0; i < 80; i++) begin
         @(posedge clk);
      end
      $stop;
   end
endmodule
