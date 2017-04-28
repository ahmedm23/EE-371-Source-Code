
module controlWater(clk, reset, water_level, water_status);
   input  logic clk, reset;
   output logic [1:0] water_status;
   input  logic [5:0] water_level;

   always_comb begin
      low = water_level < 5'd3;
      high = water_level > 5'd47;
      //mid = ~low & ~high;

      water_status[1] = low | high; // ok to open gate?
      water_status[0] = high; // which gate is ok to open
   end
endmodule
