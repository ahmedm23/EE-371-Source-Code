//`include "DFlipFlop.v"

// A four stage (4 bit) ripple up (asynchronous) counter, with active low reset.
//a. Design the counter using a gate or structural model.
//b. Use the D flip-flop model in the adjacent listing.
module rippleCounter(clk, reset, count);
   input clk, reset;
   output [3:0] count;
   wire   [3:0] countbar;
	
   DFlipFlop bit0(.clk(clk), .reset(reset), .D(countbar[0]), .q(count[0]), .qBar(countbar[0]));
   DFlipFlop bit1(.clk(countbar[0]), .reset(reset), .D(countbar[1]), .q(count[1]), .qBar(countbar[1]));
   DFlipFlop bit2(.clk(countbar[1]), .reset(reset), .D(countbar[2]), .q(count[2]), .qBar(countbar[2]));
   DFlipFlop bit3(.clk(countbar[2]), .reset(reset), .D(countbar[3]), .q(count[3]), .qBar(countbar[3]));

endmodule
