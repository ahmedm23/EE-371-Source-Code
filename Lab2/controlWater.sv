
module controlWater(clk, reset, water_level, water_status, w_up, w_down);
   input  logic clk, reset;
   output logic [5:0] water_level;
   input  logic water_up, water_down;

   enum {low, high, raise, lower} ps, ns;

   always_comb
      case (ps)
         low:   begin
                   if (w_up)   ns = raise;
                   else        ns = low;
                end
         high:  begin
                   if (w_down) ns = lower;
                   else        ns = high;
                end
         raise: begin
                   if (water_level < 
               
   
   always_ff @ (posedge clk)
      // if raise, add to counter
      // if lower add to counter
endmodule

