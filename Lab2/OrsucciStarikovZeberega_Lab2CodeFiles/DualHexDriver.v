/*
	This module displays a 6 bit value in decimal
	on two seg seven displays. from 0 to 59w
*/


module DualHexDriver (HEXL, HEXR, BCD);
	input [5:0] BCD;
	output reg [6:0] HEXL, HEXR;
	
	always @(*) begin
		if(BCD % 10 == 0)HEXR = 7'b1000000;
		else if (BCD % 10 == 1)	HEXR = 7'b1111001;
		else if (BCD % 10 == 2) HEXR = 7'b0100100;
		else if (BCD % 10 == 3) HEXR = 7'b0110000;
		else if (BCD % 10 == 4) HEXR = 7'b0011001;
		else if (BCD % 10 == 5) HEXR = 7'b0010010;
		else if (BCD % 10 == 6) HEXR = 7'b0000010;
		else if (BCD % 10 == 7) HEXR = 7'b1111000;
		else if (BCD % 10 == 8) HEXR = 7'b0000000;
		else HEXR = 7'b0010000;
		end
		
	always@(*)
		if (BCD < 10) HEXL = 7'b1000000;
		else if (BCD < 20) HEXL = 7'b1111001;
		else if (BCD < 30) HEXL = 7'b0100100;
		else if (BCD < 40) HEXL = 7'b0110000;
		else if (BCD < 50) HEXL = 7'b0011001;
		else HEXL = 7'b0010010;
			
endmodule