library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity finaltb is 
end entity;

architecture behave of finaltb is
component counters is
	port (
		clk1	:	in  std_logic;
		clk2	:	in  std_logic;
		en		:	in  std_logic;
		rst 	: 	in  std_logic;
		rstn	:	out std_logic;
		cnt1_val:	out std_logic_vector(2 downto 0);
		cnt2_val:	out std_logic_vector(4 downto 0);
		en_m1	:	out std_logic;
		en_m2	:	out std_logic
	);
end component;
component dataflow is 
	port (
		clk2	:	in  std_logic;
		rstn	:	in  std_logic;
		en_m1	:	in  std_logic;
		en_m2	:	in  std_logic;
		cnt1_val:	in  std_logic_vector(2 downto 0);
		cnt2_val:	in  std_logic_vector(4 downto 0);
		dout	:	out std_logic_vector(9 downto 0); 
	);
end component;

constant clk_per : time := 10 ns;

signal clk1_sim	:	std_logic;
signal clk2_sim	:	std_logic;
signal en_sim	:	std_logic;
signal rst_sim	:	std_logic;
signal dout_sim	:	std_logic;

signal cnt1_sim	:	std_logic_vector(2 downto 0);
signal cnt2_sim	:	std_logic_vector(4 downto 0);
signal en1_sim	:	std_logic;
signal en2_sim	:	std_logic;
signal rstn_sim :	std_logic;

begin
counters_inst : counters
	port map (
		clk1	=> clk1_sim,
		clk2	=> clk2_sim,
		en		=> en_sim,
		rst		=> rst_sim,
		
		rstn	=> rstn_sim,
		cnt1_val=> cnt1_sim,
		cnt2_val=> cnt2_sim,
		en_m1	=> en1_sim,
		en_m2   => en2_sim
	);
dataflow_inst : dataflow
	port map (
		cnt1_val	=> cnt1_sim,
		cnt2_val	=> cnt2_sim,
		clk2		=> clk2_sim,
		rstn		=> rstn_sim,
		en_m1		=> en1_sim,
		en_m2		=> en2_sim,
		dout		=> dout_sim
	);
	
clk1_proc:process
begin
	clk1_sim <= '0';
	wait for clk_per;
	clk1_sim <= not clk1_sim;
	wait for clk_per;
end process;

clk2_proc:process
	clk2_sim <= '0';
	wait for clk_per*2;
	clk2_sim <= not clk2_sim;
	wait for clk_per*2;
end process;

reset_proc:process
begin
	rst_sim <= '1';
	wait for clk_per*5/2;
	rst_sim <= not rst_sim;
	wait;
end process;

en_proc:process
begin
	en_sim <= '0';
	wait for clk_per*7/2;
	en_sim <= '1';
	wait;
end process;

end behave;
	

