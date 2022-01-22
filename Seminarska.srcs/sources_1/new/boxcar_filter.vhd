----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2022 23:48:43
-- Design Name: 
-- Module Name: boxcar_filter - Behavioral
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

entity boxcar_filter is
    Generic (
        width : integer := 7;
        window : integer := 7);
    Port (
        clk : in std_logic;
        new_sample : in std_logic;
        pcm_in : in std_logic_vector (width-1 downto 0);
        pcm_out : out std_logic_vector (width-1 downto 0));
end boxcar_filter;

architecture Behavioral of boxcar_filter is

    signal pcm_prev : unsigned (width-1 downto 0) := (others => '0');
    signal buff : std_logic_vector (window*width-1 downto 0) := (others => '0');
    signal last : std_logic_vector (width-1 downto 0);
    signal y : unsigned (width-1 downto 0);

begin

    process(clk)
    begin
        if (clk'event and clk = '1') then
            if new_sample = '1' then
                last <= buff(window*width-1 downto window*width-width); -- x_n-N
                y <= unsigned(pcm_in) + pcm_prev - unsigned(last);
                pcm_prev <= y;
                pcm_out <= std_logic_vector(y);
                -- shiftamo za width v levo in desno zapisemo nov pcm_in
                buff <= buff(window*width-1-width downto 0) & pcm_in;
            end if;
        end if;
    end process;

end Behavioral;