
module nios_system (
	char_complete_export,
	char_complete_tx_export,
	clk_clk,
	data_export,
	data_in_export,
	data_out_export,
	keys_export,
	leds_export,
	load_export,
	reset_reset_n,
	switches_export,
	tx_enable_export);	

	input		char_complete_export;
	input		char_complete_tx_export;
	input		clk_clk;
	input	[2:0]	data_export;
	input	[7:0]	data_in_export;
	output	[7:0]	data_out_export;
	input	[3:0]	keys_export;
	output	[9:0]	leds_export;
	output		load_export;
	input		reset_reset_n;
	input	[6:0]	switches_export;
	output		tx_enable_export;
endmodule
