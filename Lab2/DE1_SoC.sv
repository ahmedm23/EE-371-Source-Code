module DE1_SoC(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input  CLOCK_50; // 50MHz clock.
	input  [3:0] KEY; // True when not pressed, False when pressed
	input  [9:0] SW;
	output  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output  [9:0] LEDR;
	 
	// Clock divider
	// tBase[0] == 50MHz
	// tBase[1] == 25MHz
	// tBase[2] == 12.5MHz
	reg [25:0] tBase;
	always@(posedge CLOCK_50) tBase <= tBase + 1'b1;
	
//  arr_sw   SW0 -- arr_li   LEDR0
//  dep_sw   SW1 -- dep_li   LEDR1
//  gate1_sw Sw2 -- gate1_li LEDR2  
//  gate2_sw Sw3 -- gate2_li LEDR3
//  w_up    KEY1
//  w_down  KEY2
//  reset   KEY0

	controlMain main (.clk(tBase[23]), .reset(~KEY[0]), 
							.arr_sw(SW[0]), .dep_sw(SW[1]), .gate1_sw(SW[2]), .gate2_sw(SW[3]),
                     .w_up(~KEY[1]), .w_down(~KEY[2]), 
							.arr_li(LEDR[0]), .dep_li(LEDR[1]), .gate1_li(LEDR[2]), .gate2_li(LEDR[3]));

//	logic G1, G2, G1_f, G2_f;
//	mux_gate mg (.G1(SW[2]), .G2(SW[3]), .dir(SW[5]), .(G1_f, .G2_f);
//
//	logic L1, L2, L1_f, L2_f;
//	mux_gate_light mgl (.L1(LEDR[2]), .L2(LEDR[3]), .dir(SW[5]), .L1_f, .L2_f);

//	controlMain main (.clk(tBase[23]), .reset(~KEY[0]), 
//							.arr_sw(SW[0]), .dep_sw(SW[1]), .gate1_sw(G1_f), .gate2_sw(G2_f),
//                     .w_up(~KEY[1]), .w_down(~KEY[2]), 
//							.arr_li(LEDR[0]), .dep_li(LEDR[1]), .gate1_li(LEDR[2]), .gate2_li(LEDR[3]));		
						
endmodule

// if SW5 == 1, ship is going from region 3 to 1
// flip up arrival sw, arrival light turns on 

//module mux_gate(G1, G2, dir, G1_f, G2_f);
//	input logic G1, G2, dir;
//	output logic G1_f, G2_f;
//	assign G1_f = (G2 & dir) | (G1 & ~dir);
//	assign G2_f = (G1 & dir) | (G2 & ~dir);
//endmodule
//
//module mux_gate_light(L1, L2, dir, L1_f, L2_f);
//	input logic L1, L2, dir;
//	output logic L1_f, L2_f;
//	assign L1_f = (L2 & dir) | (L1 & ~dir);
//	assign L2_f = (L1 & dir) | (L2 & ~dir);
//endmodule

//module mux_gate_li(out, i0, i1, sel);
//	input logic i0, i1, sel;
//	output logic out;
//	assign out = (i1 & sel) | (i0 & ~sel);
//endmodule