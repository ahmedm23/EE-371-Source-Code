module controlMain (clk, reset);  
	input clk, reset;

	controlOccupied (status, clk, reset, flag)
	controlWater(clk, reset, water_level, water_status);
	controlGate(clk, reset,   
  
endmodule
