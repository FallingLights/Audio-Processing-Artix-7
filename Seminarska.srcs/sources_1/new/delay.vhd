----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.01.2022 01:32:55
-- Design Name: 
-- Module Name: delay - Behavioral
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

entity delay is
    Generic (
        width : integer := 7;
        limit : integer := 128;
        num_delay : integer := 5);
    Port (
        clk : in std_logic;
        new_sample : in std_logic;
        pcm_in : in std_logic_vector (width-1 downto 0);
        pcm_delay : out std_logic_vector (width-1 downto 0));
end delay;

architecture Behavioral of delay is

    signal count : integer range 0 to num_delay := 0;
    signal ix : integer range 0 to num_delay*width-1 := 0;
    signal buff : std_logic_vector (num_delay*width-1 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            if new_sample = '1' then
                ix <= count * width;
                pcm_delay <= buff(ix+width-1 downto ix);
                buff(ix+width-1 downto ix) <= pcm_in;
                if count = num_delay-1 then
                    count <= 0;
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
