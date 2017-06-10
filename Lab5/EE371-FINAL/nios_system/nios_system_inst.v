	nios_system u0 (
		.char_complete_export    (<connected-to-char_complete_export>),    //    char_complete.export
		.char_complete_tx_export (<connected-to-char_complete_tx_export>), // char_complete_tx.export
		.clk_clk                 (<connected-to-clk_clk>),                 //              clk.clk
		.data_export             (<connected-to-data_export>),             //             data.export
		.data_in_export          (<connected-to-data_in_export>),          //          data_in.export
		.data_out_export         (<connected-to-data_out_export>),         //         data_out.export
		.keys_export             (<connected-to-keys_export>),             //             keys.export
		.leds_export             (<connected-to-leds_export>),             //             leds.export
		.load_export             (<connected-to-load_export>),             //             load.export
		.reset_reset_n           (<connected-to-reset_reset_n>),           //            reset.reset_n
		.switches_export         (<connected-to-switches_export>),         //         switches.export
		.tx_enable_export        (<connected-to-tx_enable_export>)         //        tx_enable.export
	);

