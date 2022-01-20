----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2022 22:19:29
-- Design Name: 
-- Module Name: echo_process_data - Behavioral
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

entity echo_process_data is
    Generic (
        width : integer := 7;
        num_echo: integer := 5);
    Port (
        clk : in std_logic;
        new_sample : in std_logic;
        pcm_in : in std_logic_vector (width-1 downto 0);
        pcm_echo : out std_logic_vector (width-1 downto 0));
end echo_process_data;

architecture Behavioral of echo_process_data is

    signal count : integer range 0 to num_echo := 0;
    signal ix : integer range 0 to num_echo*width := 0;
    signal buff : std_logic_vector (num_echo*width-1 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            if new_sample = '1' then
                ix <= count * width;
                -- preden ga prepisemo, ga zapisemo v pcm_echo
                pcm_echo <= buff(ix+width-1 downto ix);
                buff(ix+width-1 downto ix) <= pcm_in;
                if count = num_echo-1 then
                    count <= 0;
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

end Behavioral;
