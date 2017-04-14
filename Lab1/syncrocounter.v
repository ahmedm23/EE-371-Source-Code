// A four stage (4 bit) synchronous up counter, with active low reset.
	//a. Design the counter using a dataflow model.
	//b. Use the D flip-flop model in the adjacent listing.
module syncrocounter (clk, reset, next);
	input clk, reset;
	wire [3:0] curr, qBar;
	output [3:0] next;
	
	assign next[0] = ~curr[0];
	assign next[1] = curr[0]^curr[1];
	assign next[2] = curr[2]^(curr[1] & curr[0]);
	assign next[3] = curr[3]^(curr[2] & curr[1] & curr[0]);
	
	DFlipFlop bit0(.clk(clk), .reset(reset), .D(next[0]), .q(curr[0]), .qBar(qBar[0]));
	DFlipFlop bit1(.clk(clk), .reset(reset), .D(next[1]), .q(curr[1]), .qBar(qBar[0]));
	DFlipFlop bit2(.clk(clk), .reset(reset), .D(next[2]), .q(curr[2]), .qBar(qBar[0]));
	DFlipFlop bit3(.clk(clk), .reset(reset), .D(next[3]), .q(curr[3]), .qBar(qBar[0]));
endmodule



