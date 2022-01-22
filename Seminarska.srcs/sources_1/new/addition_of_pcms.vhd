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
        SW : in std_logic_vector (15 downto 0);
        pcm_in : in std_logic_vector (width-1 downto 0);
        pcm_echo : in std_logic_vector (width-1 downto 0);
        
        pcm_out : out std_logic_vector (width-1 downto 0));
end addition_of_pcms;

architecture Behavioral of addition_of_pcms is

    signal sum : unsigned (width-1 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if (rising_edge(clk)) then
            if rst = '1' then --reset event
                sum <= (others => '0');
                pcm_out <= (others => '0');
            elsif new_sample = '1' then -- Normalno delovanje
--                -- ce uporabnik zeli echo ga dobi, drugace normalno predvaja
--                if SW(14) = '1' then -- echo
--                    sum <= unsigned(pcm_in) + (shift_right(unsigned(pcm_echo), 4));
--                    pcm_out <= std_logic_vector(sum);
--                elsif SW(13) = '1' then -- delay
--                    pcm_out <= pcm_echo;
--                elsif SW(12) = '1' then -- inverse echo
--                    sum <= unsigned(pcm_echo) + (shift_right(unsigned(pcm_in), 4));
--                    pcm_out <= std_logic_vector(sum);
--                else -- nic
--                    pcm_out <= pcm_in;
--                end if;
                sum <= unsigned(pcm_in) + (shift_right(unsigned(pcm_echo), 4));
                pcm_out <= std_logic_vector(sum);
            end if;
        end if;
    end process;

end Behavioral;
