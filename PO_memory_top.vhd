library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory_top is

	generic
	(
		DATA_WIDTH_TOP : natural := 8;
		ADDR_WIDTH_TOP : natural := 16
	);
	
	port 
	(
		clk_top				: in std_logic;
		reset_top			: in std_logic;
		reqleit_top   		: in std_logic;
		address_top 		: in natural range 0 to (ADDR_WIDTH_TOP-1);
		dadoPrt_top   		: in std_logic;
		data_out_top	  	: out std_logic_vector ((DATA_WIDTH_TOP-1) downto 0)
	);

end entity;

architecture rtl of memory_top is

component PO_Memory is

	generic
	(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 16
	);
	
	port 
	(
		clk			: in std_logic;
		address		: in natural range 0 to (ADDR_WIDTH-1);
		reqleit		: in std_logic;
		dadoPrt		: out std_logic;
		ack_in	 	: in std_logic;
		ack_mem	 	: out std_logic;
		data_out	: out std_logic_vector ((DATA_WIDTH-1) downto 0)
	);

end component;

component PC_Memory is

	generic
	(
		DATA_WIDTH : natural := 8;
		ADDR_WIDTH : natural := 16
	);
	
	port 
	(
		clk			: in std_logic;								
		reqleit		: in std_logic;
		reset		: in std_logic;
		dadoPrt		: out std_logic;
		ack_in	 	: in std_logic;
		ack_mem	 	: out std_logic;
		address		: out natural range 0 to (ADDR_WIDTH-1)
	);

end component;

signal reqleit_conn: std_logic;
signal address_conn: natural range 0 to (ADDR_WIDTH_TOP-1);
signal dadoPrt_conn: std_logic;
signal data_out_conn: std_logic_vector ((DATA_WIDTH_TOP-1) downto 0);
signal clk_conn: std_logic;
signal ack_in_conn: std_logic;
signal ack_mem_conn: std_logic;

begin

PC: PC_Memory port map (
		clk	    => clk_conn,
		reset	=> reset_top,
		reqleit => reqleit_conn,
		dadoPrt => dadoPrt_conn,
		ack_in  => ack_in_conn,
		ack_mem => ack_mem_conn
		);

PO: PO_Memory port map (
		reqleit => reqleit_conn,
		dadoPrt => dadoPrt_conn,
		address => address_conn,
		data_out => data_out_conn,
		clk		=> clk_conn,
		ack_in	=> ack_in_conn,
		ack_mem => ack_mem_conn
		);

end rtl;