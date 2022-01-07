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
        width_in : integer := 8;
        limit_in : integer := 128);
    Port (
        clk : in std_logic;
        event_sample : in std_logic;
        echo : in std_logic;
        pcm_in : in std_logic_vector (width_in - 1 downto 0);
        pcm_echo : in std_logic_vector (width_in - 1 downto 0);
        pcm_sum : out std_logic_vector (width_in - 1 downto 0));
end addition_of_pcms;

architecture Behavioral of addition_of_pcms is

    signal sum : unsigned (width_in - 1 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            if event_sample = '1' then
                -- ce uporabnik zeli echo ga dobi, drugace normalno predvaja
                if echo = '1' then
                    sum <= unsigned(pcm_in) + unsigned(pcm_echo);
                    pcm_sum <= std_logic_vector(sum(width_in - 1 downto 0));
                else
                    pcm_sum <= pcm_in;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
