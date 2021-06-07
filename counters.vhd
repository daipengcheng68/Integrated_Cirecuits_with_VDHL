library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity conters is 
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
end entity;

architecture behave of counters is 

signal en1		: std_logic;
signal cnt2_en 	: std_logic;
signal cnt1_int	: std_logic_vector(2 downto 0);
signal cnt2_int : std_logic_vector(4 downto 0);
	
begin 
--asyn. 
--high rst
--rising_edge
	cnt1_proc : process
	begin
		if rst = '1' then
			cnt1_int <= (others => '0');
			en1 <= '0';
		elsif rising_edge (clk1) then
			if en = '1' then 
				cnt1_int <= cnt1_int + 1;
				if  cnt1_int = "101" then
					en1 <= '1';
				else 
					en1 <= '0';
				end if;
			else 
				cnt1_int <= cnt1_int;
			end if;
		end if;
	end process;
	
	ff_proc : process
	begin 
		if rst = '1' then 
			cnt2_en <= '0';
		elsif rst = '0' then
			if rising_edge (clk2) then
				cnt2_en <= '1';
			end if;
		end if;
	end process;
	
	cnt2_proc : process
	begin
		if rst = '1' then
			cnt2_int <= (others <= '0');
			en_m1 <= '0';
			en_m2 <= '0';
		elsif rising_edge (clk2) then
			if cnt2_en = '1';
				cnt2_int <= cnt2_int + 1;
				if cnt2_int = "01001" then
					en_m1 <= '1';
				elsif cnt2_int <= "01111" then 
					en_m2 <= '0';
				else 
					en_m1 <= '0';
					en_m2 <= '0';
				end if;
			else 
				cnt2_int <= cnt2_int;
			end if;
		end if;
	end process;
	
	inverter_proc:process
	begin 
		if rst ='1' then
			rstn <= '0';
		else 
			rstn <= not rstn;
		end if;
	end process;
	
	cnt1_val <= cnt1_int;
	cnt2_val <= cnt2_int;
	
end behave;
		
	
	
	
	
	
	
	
	
	