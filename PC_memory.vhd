-- Quartus II VHDL Template
-- Four-State Moore State Machine

-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity PC_Memory is

	port(
		clk	     : in std_logic;
		reset	 : in std_logic;
		--address	 : in natural range 0 to 15;
		reqleit	 : in std_logic;
		ack_in	 : in std_logic;
		ack_mem	 : out std_logic;
		dadoPrt  : out std_logic
	);

end entity;

architecture rtl of PC_Memory is

	type state_type is (s0, s1, s2, s3);

	signal state   : state_type;

begin
	
	process (clk, reset, reqleit, ack_in)
	begin
		if reset = '1' then
			state <= s0;
		else
			if reqleit = '1' then
				case state is
					when s0=>
						state <= s1;
					when s1=>
						if reqleit = '1' then
							state <= s1;
						else
							state <= s2;
						end if;
					when s2=>
						if ack_in = '1' then
							state <= s2;
						else	
							state <= s3;
						end if;
					when s3=>
						state <= s3;
				end case;
			end if;
		end if;
	end process;

	process (state) is 
	begin
		case state is
			when s0 =>
				dadoPrt <= '0';
				ack_mem <= ack_in;
			when s1 =>
				dadoPrt <= '0';
				ack_mem <= ack_in; 
			when s2 =>
				dadoPrt <= '1';
				ack_mem <= ack_in;
			when s3 =>
				dadoPrt <= '0';
				ack_mem <= ack_in;
		end case;
	end process;

end rtl;
