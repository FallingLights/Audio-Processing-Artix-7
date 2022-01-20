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
        width_pcm : integer := 7;
        limit_dec : integer := 10);
    Port (
        clk : in std_logic;
        new_sample : in std_logic;
        pcm_in : in std_logic_vector (width_pcm-1 downto 0);
        pcm_out : out std_logic_vector (width_pcm-1 downto 0));
end decimation;

architecture Behavioral of decimation is

    signal count : integer range 0 to limit_dec := 0;

begin

    process (clk)
    begin
        if clk'event and clk = '1' then
            if new_sample = '1' then
                if count = limit_dec-1 then
                    count <= 0;
                    pcm_out <= pcm_in;
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
