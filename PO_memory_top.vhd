library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_top is

	generic
	(
		DATA_WIDTH_TOP : natural := 8;
		ADDR_WIDTH_TOP : natural := 4
	);
	
	port 
	(
		clk_top				: in std_logic;
		reset_top			: in std_logic;
		reqleit_top   		: in std_logic;
		address_top 		: in std_logic_vector ((ADDR_WIDTH-1) downto 0);
		dadoPrt_top   		: in std_logic;
		data_out_top	  	: out std_logic_vector ((DATA_WIDTH_TOP-1) downto 0);
	);

end entity;

architecture rtl of memory_top is

component PO_Memory is

	generic
	(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 4
	);
	
	port 
	(
		address	: in std_logic_vector ((ADDR_WIDTH-1) downto 0);
		reqleit	: in std_logic;
		dadoPrt	: out std_logic;
		data_out: out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);

end component;

component PC_Memory is

	generic
	(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 4
	);
	
	port 
	(
		clk			: in std_logic;								
		reqleit		: in std_logic;
		reset		: in std_logic;
		ack_mem		: out std_logic;
		ack_io		: in std_logic;
		dadoPrt		: out std_logic;
		address		: in std_logic_vector ((ADDR_WIDTH-1) downto 0);
	);

end component;

signal reqleit_conn: std_logic;
signal address_conn: std_logic_vector (3 downto 0);
signal dadoPrt_conn: std_logic;
signal data_out_conn: std_logic_vector (7 downto 0);

begin

PC: PC_Memory port map (
		clk	    => clk_top,
		reset	=> reset_top,
		reqleit => reqleit_conn,
		dadoPrt => dadoPrt_conn,
		);

PO: 
	 PO_Memory 
		--generic map(DATA_WIDTH => DATA_WIDTH_TOP)
		port map (
		clk	 => clk_top,
		reset=> reset_top,
		reqleit => reqleit_conn,
		dadoPrt => dadoPrt_conn
		);

end rtl;