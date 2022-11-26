library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is

	generic(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 16
	);
	
	port (
		clk			: in std_logic;								
		reqleit		: out std_logic;
		reset		: in std_logic;
		ack_mem		: out std_logic;
		ack_io		: out std_logic;
		dadoPrt		: out std_logic;
		address		: out natural range 0 to (ADDR_WIDTH-1);
		data_out	: out std_logic_vector((DATA_WIDTH-1) downto 0)
	);

end memory;

architecture logica of memory is
	type type_state is (e0, e1, e2, e3);
	signal atual_state : type_state;
	signal reg_state: type_state;
	
begin
	process(clk, reg_state)
	begin
		if(clk'event and clk = '1') then 
			atual_state <= reg_state;
		end if;
	end process;
	
	process (reset, atual_state)
	begin
		if (reset = '1') then 
			reg_state <= e0;
		else
			case atual_state is 
				when e0 =>
					ack_mem <= '0';
					ack_io <= '0';
					address <= 0;
					reqleit <= '1';
					reg_state <= e1;
				when e1 =>
					address <= 2;
					ack_mem <= '1';
					reqleit <= '0';
					reg_state <= e2;
				when e2 =>
					ack_mem <= '0';
					dadoPrt <= '1';
					ack_io <= '1';
					reg_state <= e3;
				when e3 =>
					dadoPrt <= '0';
					ack_io <= '0';
					reg_state <= e0;
			end case;
		end if;
	end process;
end logica;