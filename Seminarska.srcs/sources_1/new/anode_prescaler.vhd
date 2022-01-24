----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2021 08:49:33
-- Design Name: 
-- Module Name: prescaler - Behavioral
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

entity anode_prescaler is
    Generic ( limit : integer := 100000);
    Port ( clk : in std_logic;
           enable : out std_logic);
end anode_prescaler;

architecture Behavioral of anode_prescaler is

signal count : unsigned (27 downto 0);

begin

process (clk)
begin
    if clk'event and clk = '1' then
        if count = limit then
            count <= (others => '0');
            enable <= '1';
        else
            count <= count + 1;
            enable <= '0';
        end if;
    end if;
end process;

end Behavioral;
