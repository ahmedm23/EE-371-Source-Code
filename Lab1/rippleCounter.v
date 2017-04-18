
module rippleCounter(clk, reset, count);
   input clk, reset;
   output [3:0] count;
   wire   [3:0] countbar;

   // bit0 to bit3's outputs are the lowest to highest bit of the count
   // clk goes to lowest bit's DFF
   // qBar of each bit goes to clk of the next bit up
   DFlipFlop bit0(.clk(clk), .reset(reset), .D(countbar[0]), .q(count[0]), .qBar(countbar[0]));
   DFlipFlop bit1(.clk(countbar[0]), .reset(reset), .D(countbar[1]), .q(count[1]), .qBar(countbar[1]));
   DFlipFlop bit2(.clk(countbar[1]), .reset(reset), .D(countbar[2]), .q(count[2]), .qBar(countbar[2]));
   DFlipFlop bit3(.clk(countbar[2]), .reset(reset), .D(countbar[3]), .q(count[3]), .qBar(countbar[3]));

endmodule
