/*
	Top Level Module
	connecting the lock module to the inpouts and outputs
	on the DE1-SoC board

	Last Modified: 1.24.17
*/


module DE1_SoC_Lock(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
		input  logic			CLOCK_50; //50MHz clock
		output logic	[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
		output logic	[9:0] LEDR;
		input  logic	[3:0] KEY;
		input  logic	[9:0] SW;
		wire [5:0] waterLevel;
		
		assign HEX2 = 7'b1111111;
		assign HEX3 = 7'b1111111;
		assign HEX4 = 7'b1111111;
		assign HEX5 = 7'b1111111;

		lock lock(.Clock(CLOCK_50), .Reset(KEY[0]), .upperSwitch(SW[2]), .lowerSwitch(SW[3]),
			.upperGate(LEDR[2]), .lowerGate(LEDR[3]), .waterUp(~KEY[1]), .waterDown(~KEY[2]), .arriving(SW[0]),
			 .departing(SW[1]), .occupied(LEDR[9]), .waterLevel(waterLevel));

		assign LEDR[0] = SW[0];
		assign LEDR[1] = SW[1];

		DualHexDriver WL (.HEXL(HEX1), .HEXR(HEX0), .BCD(waterLevel));
		
endmodule // DE1_SoC_Lock