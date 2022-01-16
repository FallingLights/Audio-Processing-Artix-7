----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2021 01:22:57
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity pdm2pcm is
    Generic (
        width : integer := 8;
        limit : integer := 128);
    Port (
        clk : in std_logic;
        clk_sample : in std_logic;
        event_sample : in std_logic;
        m_enable : in std_logic;
        m_data : in std_logic;
        pcm : out std_logic_vector (width-1 downto 0));
end pdm2pcm;

architecture Behavioral of pdm2pcm is

    signal count1 : std_logic := '0';
    signal depth1 : unsigned (width-1 downto 0) := (others => '0');
    signal ones1 : unsigned (width-1 downto 0) := (others => '0');

    signal count2 : std_logic := '0';
    signal depth2 : unsigned (width-1 downto 0) := (others => '0');
    signal ones2 : unsigned (width-1 downto 0) := (others => '0');

begin

    process (clk)
    begin
        if clk'event and clk = '1' then
            if event_sample = '1' then
                if clk_sample = '1' then
                    pcm <= std_logic_vector(ones1);
                    count1 <= '1';
                    depth1 <= (others => '0');
                    ones1 <= (others => '0');
                elsif clk_sample = '0' then
                    pcm <= std_logic_vector(ones2);
                    count2 <= '1';
                    depth2 <= (others => '0');
                    ones2 <= (others => '0');
                end if;
            end if;
            if m_enable = '1' then
                if count1 = '1' then
                    if depth1 < limit then
                        depth1 <= depth1 + 1;
                        if m_data = '1' then
                            ones1 <= ones1 + 1;
                        end if;
                    end if;
                end if;
                if count2 = '1' then
                    if depth2 < limit then
                        depth2 <= depth2 + 1;
                        if m_data = '1' then
                            ones2 <= ones2 + 1;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
