----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 20:11:03
-- Design Name: 
-- Module Name: anode_switcher - Behavioral
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

entity anode_switcher is
    Port ( clk : in std_logic;
           enable : in std_logic;
           anode : out std_logic_vector (7 downto 0));
end anode_switcher;

architecture Behavioral of anode_switcher is

signal count : integer range 0 to 7 := 0;

begin

    process (count)
    begin
        case count is
            when 0 => anode <= "11111110";
            when 1 => anode <= "11111101";
            when 2 => anode <= "11111011";
            when 3 => anode <= "11110111";
            when 4 => anode <= "11101111";
            when 5 => anode <= "11011111";
            when 6 => anode <= "10111111";
            when 7 => anode <= "01111111";
            when others => anode <= "01111111";
        end case;
    end process;

    process(clk)
    begin
        if clk'event and clk = '1' then
	       if count = 7 then
               count <= 0;
	       elsif enable = '1' then
               count <= count + 1;
		   end if ;
	    end if ;
    end process;

end Behavioral;
