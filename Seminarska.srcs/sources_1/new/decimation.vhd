----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2022 15:45:21
-- Design Name: 
-- Module Name: decimation - Behavioral
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

entity decimation is
    Generic (
        width_dec : integer := 4;
        limit_dec : integer := 10;
        width_pmc : integer := 8);
    Port (
        clk : in STD_LOGIC;
        event_sample : in std_logic;
        pcm_in : in std_logic_vector (width_pmc - 1 downto 0);
        enable_dec : out STD_LOGIC;
        pcm_out : out std_logic_vector (width_pmc - 1 downto 0));
end decimation;

architecture Behavioral of decimation is

    signal count_dec : unsigned (width_dec - 1 downto 0) := (others => '0');

begin

    process (clk)
    begin
        if clk'event and clk = '1' then
            if event_sample = '1' then
                if count_dec = limit_dec then
                    count_dec <= (others => '0');
                    enable_dec <= '1';
                    pcm_out <= pcm_in;
                else
                    count_dec <= count_dec + 1;
                    enable_dec <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
