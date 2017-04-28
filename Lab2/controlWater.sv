
module controlWater(clk, reset, water_level, water_status);
   input  logic clk, reset;
   output logic [1:0] water_status;
   input  logic [5:0] water_level;
   logic low, high;

   always_comb begin
      low = water_level < 6'd3;
      high = water_level > 6'd47;

      water_status[1] = low | high; // ok to open gate?
      water_status[0] = high; // which gate is ok to open
   end
endmodule

module controlWater_testbench();
   logic clk, reset;
   logic [5:0] water_level;
   logic [1:0] water_status;

   controlWater dut(.clk, .reset, .water_level, .water_status);

   // Loop through possible values of water_level
   integer i;
   initial begin
      for (i = 0; i <= 60; i++) begin
         water_level = i; #10;
      end
   end
endmodule
