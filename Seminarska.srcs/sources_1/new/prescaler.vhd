----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2021 09:52:24
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

entity prescaler is
    Port ( clk : in std_logic;
           clk_new : inout std_logic;
           enable : out std_logic);
end prescaler;

architecture Behavioral of prescaler is

signal count : unsigned (11 downto 0);

begin

process(clk)
begin
    if clk'event and clk = '1' then
        if count = 25 then
            count <= (others => '0');
            clk_new <= not clk_new;
            if clk_new = '1' then
                enable <= '1';
            else
                enable <= '0';
            end if;
        else
            count <= count + 1;
            enable <= '0';
        end if;
    end if;
end process;

end Behavioral;
