//`include "rippleCounter.v"
//`include "johnsonCounter.v"
//`include "syncrocounter.v"
//`include "SchemEntryCounter.v"

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW); 
	input 		 CLOCK_50; // 50MHz clock.
	input  [3:0] KEY; // True when not pressed, False when pressed
	input  [9:0] SW;	
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	
	// Clock divider
	// tBase[0] == 50MHz
	// tBase[1] == 25MHz
	// tBase[2] == 12.5MHz
	reg [25:0] tBase;
	always@(posedge CLOCK_50) tBase <= tBase + 1'b1;
	
//	rippleCounter rCounter (.clk(tBase[23]), .reset(SW[0]), .count(LEDR[3:0]));
	syncrocounter synCounter (.clk(tBase[23]), .reset(SW[0]), .next(LEDR[3:0]));
//	johnsonCounter jCounter (.clk(tBase[23]), .reset(SW[0]), .count(LEDR[3:0]));
//	SchemEntryCounter schemCounter (.clk(tBase[23]), .reset(SW[0]), .out1(LEDR[0]), .out2(LEDR[1]), .out3(LEDR[2]), .out4(LEDR[3]));
	

endmodule
		

 

//divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,[25] = 0.75Hz, ...
//module clock_divider (clock, divided_clocks);
//	input clock;
//	output reg [31:0] divided_clocks;
//	
//	initial
//		divided_clocks <= 0;
//	always @(posedge clock)
//		divided_clocks <= divided_clocks + 1;
//endmodule

module counterTestBench;
	wire clk, reset;
	wire[3:0] rippleCount, johnsonCount, syncroCount, schemCount;
	
	rippleCounter rCounter (clk, reset, rippleCount);
	syncrocounter synCounter (clk, reset, syncroCount);
	johnsonCounter jCounter (clk, reset, johnsonCount);
	SchemEntryCounter schemCounter (.reset(reset), .clk(clk), .out1(schemCount[0]), .out2(schemCount[1]), .out3(schemCount[2]), .out4(schemCount[3]));
	
	Tester test(rippleCount, johnsonCount, syncroCount, schemCount, clk, reset);
	
	
	initial begin
		$dumpfile("counterTesterLog.vcd");
		$dumpvars;
	end
endmodule
	
module Tester(rippleCount, johnsonCount, syncroCount, schemCount, clk, reset);
	input [3:0] rippleCount, johnsonCount, syncroCount, schemCount;
	output clk, reset;
	reg clk, reset;
	
	initial begin
		$display("\t\t clk \t reset \t rippleCount \t johnsonCount \t syncroCount \t schemCount");
		$monitor("\t\t %b  \t %b    \t %b          \t %b           \t %b          \t %b", 
			     clk, reset, rippleCount, johnsonCount, syncroCount, schemCount);
	end
	
	parameter CLOCK = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK/2) clk <= ~clk;
	end

	initial begin @(posedge clk)
		reset <= 0; @(posedge clk)@(posedge clk)
		reset <= 1; @(posedge clk)@(posedge clk)
		repeat(30)@(posedge clk);
		$stop;
	end
	

endmodule