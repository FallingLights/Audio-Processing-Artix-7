----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2022 08:18:24
-- Design Name: 
-- Module Name: debouncer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity btn_debounce is
    Generic (
        limit : integer := 65536);
    Port (
        clk : in std_logic;
        btn_in : in std_logic;
        btn_out : out std_logic);
end btn_debounce;

architecture Behavioral of btn_debounce is

    signal count : integer range 0 to 65536 := 0;
    signal btn_temp : std_logic := '0';

begin

	debounce : process(clk)
	begin
	   if clk'event and clk = '1' then
	       if count = limit then
	           btn_temp <= not btn_temp;
	       end if;
	   end if;
	end process;
	
	counter : process(clk)
	begin
		if clk'event and clk = '1' then
			if btn_in = '1' xor btn_temp = '1' then
				if count = limit then
					count <= 0;
				else
					count <= count + 1;
				end if;
			else
				count <= 0;
			end if;
		end if;
	end process;

	btn_out <= btn_temp;
	
end Behavioral;
