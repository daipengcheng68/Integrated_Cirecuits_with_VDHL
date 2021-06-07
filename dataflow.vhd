library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dataflow is 
	port (
		clk2	:	in  std_logic;
		rstn	:	in  std_logic;
		en_m1	:	in  std_logic;
		en_m2	:	in  std_logic;
		cnt1_val:	in  std_logic_vector(2 downto 0);
		cnt2_val:	in  std_logic_vector(4 downto 0);
		dout	:	out std_logic_vector(9 downto 0)
	);
end entity;

architecture behave of dataflow is

signal ff1_int	:	std_logic_vector(2 downto 0);
signal ff2_int	:	std_logic_vector(4 downto 0);
signal mux1_int	:	std_logic_vector(4 downto 0);
signal add_int	:	std_logic_vector(5 downto 0);
signal mul_int	:	std_logic_vector(9 downto 0);
signal mux2_int	: 	std_logic_vector(9 downto 0);
signal r_int	:	std_logic_vector(9 downto 0);

begin
--synch.
--low rstn
--falling_edge
	ff1_proc : process
	begin 
		if falling_edge (clk2) then
			if rstn = '0' then
				ff1_int <= (others=> '0');
			else
				ff1_int <= cnt1_val;
			end if;
		else 
			ff1_int <= ff1_int;
		end if;
	end process;
	
	ff2_proc : process
	begin 
		if falling_edge (clk2) then
			if rstn = '0' then 
				ff2_int <= (others=> '0');
			else 
				ff2_int <= cnt2_val;
			end if;
		else
			ff2_int <= ff2_int;
		end if;
	end process;
	
	mux1_int	<=	ext(ff1_int,5) when en_m1 = '1' else 
					ff2_int;
	add_int		<=	ext(mux1_int,6) + ext(ff2_int,6);
	mul_int		<=	mux1_int * ff2_int;
	
	mux2_int	<=	ext(add_int,10) when en_m2 = '1' else
					mul_int;
	
	reg_proc : process
	begin
		if falling_edge (clk2) then
			if rstn = '0' then
				r_int <= (others => '0');
			else
				r_int <= mux2_int;
			end if;
		else
			r_int <= r_int;
		end if;
	end process;
	
	dout <= r_int;

end behave;	
	





