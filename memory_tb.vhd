library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity memory_tb is
end entity;

architecture behavior of memory_tb is
	component memory is 
		port (
				clk			: in std_logic;
				reqleit		: in std_logic;
				address		: in natural range 0 to 15;
				data_out	: out std_logic_vector(7 downto 0);
				dadoPrt		: out std_logic;
				ack_in	 	: in std_logic;
				ack_mem	 	: out std_logic
			 );
	end component;
	
	component PC_Memory is
	
		port (
				clk			: in std_logic;								
				reqleit		: in std_logic;
				reset		: in std_logic;
				dadoPrt		: out std_logic;
				ack_in	 	: in std_logic;
				ack_mem	 	: out std_logic
				
			);
	end component;
	
	signal reqleit_sg 	: std_logic;
	signal clk_sg	 	: std_logic;
	signal address_sg 	: natural;
	signal data_out_sg 	: std_logic_vector(7 downto 0);
	signal dadoPrt_sg 	: std_logic;
	signal ack_in_sg 	: std_logic;
	signal ack_mem_sg 	: std_logic;
	signal reset_sg		: std_logic;
	
	begin 
	
	PO: memory
		port map (
			clk 		=> clk_sg,
			reqleit 	=> reqleit_sg,
			address 	=> address_sg,
			data_out 	=> data_out_sg,
			dadoPrt 	=> dadoPrt_sg,
			ack_in 		=> ack_in_sg,
			ack_mem 	=> ack_mem_sg
			);
	
	PC: PC_Memory
		port map (
			clk 		=> clk_sg,
			reqleit 	=> reqleit_sg,
			reset 		=> reset_sg,
			dadoPrt		=> dadoPrt_sg,
			ack_in 		=> ack_in_sg,
			ack_mem 	=> ack_mem_sg
			);
			
	process
		begin
			wait for 10 ns;
				reset_sg <= '0';
				reqleit_sg <= '1';
				address_sg <= 10;
			wait for 10 ns;
				reqleit_sg <= '0';
			wait for 10 ns;
				ack_in_sg <= '1';
		wait;
	end process;
	
	process
		begin
			clk_sg  <= '0' ;
		wait for 5 ns ;
			clk_sg  <= '1'  ;
		wait for 5 ns ;
  end process;

end behavior;