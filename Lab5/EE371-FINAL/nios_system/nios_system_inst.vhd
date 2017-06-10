	component nios_system is
		port (
			char_complete_export    : in  std_logic                    := 'X';             -- export
			char_complete_tx_export : in  std_logic                    := 'X';             -- export
			clk_clk                 : in  std_logic                    := 'X';             -- clk
			data_export             : in  std_logic_vector(2 downto 0) := (others => 'X'); -- export
			data_in_export          : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			data_out_export         : out std_logic_vector(7 downto 0);                    -- export
			keys_export             : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			leds_export             : out std_logic_vector(9 downto 0);                    -- export
			load_export             : out std_logic;                                       -- export
			reset_reset_n           : in  std_logic                    := 'X';             -- reset_n
			switches_export         : in  std_logic_vector(6 downto 0) := (others => 'X'); -- export
			tx_enable_export        : out std_logic                                        -- export
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			char_complete_export    => CONNECTED_TO_char_complete_export,    --    char_complete.export
			char_complete_tx_export => CONNECTED_TO_char_complete_tx_export, -- char_complete_tx.export
			clk_clk                 => CONNECTED_TO_clk_clk,                 --              clk.clk
			data_export             => CONNECTED_TO_data_export,             --             data.export
			data_in_export          => CONNECTED_TO_data_in_export,          --          data_in.export
			data_out_export         => CONNECTED_TO_data_out_export,         --         data_out.export
			keys_export             => CONNECTED_TO_keys_export,             --             keys.export
			leds_export             => CONNECTED_TO_leds_export,             --             leds.export
			load_export             => CONNECTED_TO_load_export,             --             load.export
			reset_reset_n           => CONNECTED_TO_reset_reset_n,           --            reset.reset_n
			switches_export         => CONNECTED_TO_switches_export,         --         switches.export
			tx_enable_export        => CONNECTED_TO_tx_enable_export         --        tx_enable.export
		);

