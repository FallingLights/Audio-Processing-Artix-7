----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2021 19:56:14
-- Design Name: 
-- Module Name: digit_to_segments - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digit2segments is
    Port ( digit : in std_logic_vector (3 downto 0);
           cathode : out std_logic_vector (7 downto 0));
end digit2segments;

architecture Behavioral of digit2segments is

begin

with digit select
    cathode <= "11000000" when X"0",
               "11111001" when X"1",
			   "10100100" when X"2",
			   "10110000" when X"3",
			   "10011001" when X"4",
			   "10010010" when X"5",
			   "10000010" when X"6",
			   "11111000" when X"7",
			   "10000000" when X"8",
			   "10010000" when X"9",
			   "10001000" when X"A",
			   "10000011" when X"B",
			   "11000110" when X"C",
			   "10100001" when X"D",
			   "10000110" when X"E",
			   "10001110" when X"F",
			   "10001110" when others;

end Behavioral;
