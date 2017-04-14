// Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 16.0.0 Build 211 04/27/2016 SJ Standard Edition"
// CREATED		"Fri Apr 14 15:47:16 2017"

module SchemEntryCounter(
	clk,
	reset,
	out1,
	out2,
	out3,
	out4
);


input wire	clk;
input wire	reset;
output wire	out1;
output wire	out2;
output wire	out3;
output wire	out4;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;

assign	out1 = SYNTHESIZED_WIRE_15;
assign	out2 = SYNTHESIZED_WIRE_16;
assign	out3 = SYNTHESIZED_WIRE_18;
assign	out4 = SYNTHESIZED_WIRE_9;




DFlipFlop	b2v_inst(
	.D(SYNTHESIZED_WIRE_0),
	.clk(clk),
	.reset(reset),
	.q(SYNTHESIZED_WIRE_15)
	);


DFlipFlop	b2v_inst1(
	.D(SYNTHESIZED_WIRE_1),
	.clk(clk),
	.reset(reset),
	.q(SYNTHESIZED_WIRE_16)
	);


DFlipFlop	b2v_inst2(
	.D(SYNTHESIZED_WIRE_2),
	.clk(clk),
	.reset(reset),
	.q(SYNTHESIZED_WIRE_18)
	);


DFlipFlop	b2v_inst3(
	.D(SYNTHESIZED_WIRE_3),
	.clk(clk),
	.reset(reset),
	.q(SYNTHESIZED_WIRE_9)
	);

assign	SYNTHESIZED_WIRE_1 = SYNTHESIZED_WIRE_15 ^ SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_2 = SYNTHESIZED_WIRE_17 ^ SYNTHESIZED_WIRE_18;

assign	SYNTHESIZED_WIRE_3 = SYNTHESIZED_WIRE_8 ^ SYNTHESIZED_WIRE_9;

assign	SYNTHESIZED_WIRE_17 = SYNTHESIZED_WIRE_15 & SYNTHESIZED_WIRE_16;

assign	SYNTHESIZED_WIRE_8 = SYNTHESIZED_WIRE_17 & SYNTHESIZED_WIRE_18;

assign	SYNTHESIZED_WIRE_0 =  ~SYNTHESIZED_WIRE_15;


endmodule
