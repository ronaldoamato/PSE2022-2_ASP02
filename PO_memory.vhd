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
		reqleit		: in std_logic;
		address		: in natural range 0 to (ADDR_WIDTH-1);					-- 16 posicoes de memoria
		dadoPrt		: out std_logic;										-- flag para permitir ou não a saida de dados da memória
		data_out	: out std_logic_vector((DATA_WIDTH -1) downto 0);		-- dado saindo da memoria
		ack_in	 	: in std_logic;
		ack_mem	 	: out std_logic
	);

end memory;

architecture rtl of memory is

	subtype word_t is std_logic_vector((DATA_WIDTH-1) downto 0);
	type memory_t is array((ADDR_WIDTH-1) downto 0) of word_t;

	function init_ram
		return memory_t is 
		variable tmp : memory_t := (others => (others => '0'));
	begin 
		for address_pos in 0 to (ADDR_WIDTH-1) loop
			-- Initialize each address with the address itself
			tmp(address_pos) := std_logic_vector(to_unsigned(address_pos, (DATA_WIDTH)));
		end loop;
		return tmp;
	end init_ram;	 

	signal ram : memory_t := init_ram;	

	signal address_reg : natural range 0 to (ADDR_WIDTH-1);

begin

	process(clk)
	begin	
		if (rising_edge(clk)) then
			if (reqleit = '1') then
				address_reg <= address;
				data_out <= ram(address_reg);
			end if;
			data_out <= ram(address_reg);
		end if;
		data_out <= ram(address_reg);
	end process;
	

end rtl;