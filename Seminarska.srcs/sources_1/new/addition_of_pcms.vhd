----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2022 23:40:22
-- Design Name: 
-- Module Name: addition_of_pcms - Behavioral
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

entity addition_of_pcms is
    Generic (
        width : integer := 7);
    Port (
        clk : in std_logic;
        rst : in std_logic;
        
        new_sample : in std_logic;
        pcm_in : in std_logic_vector (width-1 downto 0);
        pcm_echo : in std_logic_vector (width-1 downto 0);
        
        pcm_out : out std_logic_vector (width-1 downto 0));
end addition_of_pcms;

architecture Behavioral of addition_of_pcms is

    signal sum : unsigned (width-1 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if (clk'event and clk = '1') then
            if rst = '1' then --reset event
                sum <= (others => '0');
                pcm_out <= (others => '0');
            elsif new_sample = '1' then -- Normalno delovanje 
                sum <= unsigned(pcm_in) + (shift_right(unsigned(pcm_echo), 4));
                pcm_out <= std_logic_vector(sum);
            end if;
        end if;
    end process;

end Behavioral;
