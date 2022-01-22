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

entity median_filter is
    Generic (
        width : integer := 7;
        window : integer := 7);
    Port (
        clk : in std_logic;
        rst : in std_logic;
        
        new_sample : in std_logic;
        pcm_in : in std_logic_vector (width-1 downto 0);
        
        pcm_out : out std_logic_vector (width-1 downto 0));
end median_filter;

architecture Behavioral of median_filter is

    signal pcm_prev : unsigned (width-1+5 downto 0) := (others => '0');
    signal buff : std_logic_vector (window*width-1 downto 0) := (others => '0');
    signal last : std_logic_vector (width-1 downto 0);

begin

    process(clk)
    begin
        if (clk'event and clk = '1') then
            if rst = '1' then -- reset event
                --pcm_out <= (others => '0');
                pcm_prev <= (others => '0');
                buff <= (others => '0');
                last <= (others => '0');
            elsif new_sample = '1' then -- normalno delovanje
                pcm_prev <= unsigned(pcm_in) + pcm_prev - unsigned(buff(window*width-1 downto window*width-width));
                -- shiftamo za width v levo in desno zapisemo nov pcm_in
                buff <= buff(window*width-1-width downto 0) & pcm_in;
            end if;
        end if;
    end process;
    
    pcm_out <= std_logic_vector(pcm_prev (width-1 downto 0));

end Behavioral;
