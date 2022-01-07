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
        width_in : integer := 8;
        limit_in : integer := 128;
        width_num : integer := 4;
        num_echo: integer := 5);
    Port (
        clk : in std_logic;
        event_sample : in std_logic;
        pcm_in : in std_logic_vector (width_in - 1 downto 0);
        pcm_echo : out std_logic_vector (width_in - 1 downto 0));
end echo_process_data;

architecture Behavioral of echo_process_data is

    signal count : natural := 0;
    signal limit_out : std_logic_vector (width_in * num_echo - 1 downto 0) := (others => '0');
    signal down_index : natural := 0;

begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            if event_sample = '1' then
                if count - 1 = num_echo then
                    count <= 0;
                else
                    count <= count + 1;
                end if;
                down_index <= width_in * count;
                --preden ga prepisemo, ga zapisemo v pcm_echo
                pcm_echo <= limit_out(down_index + width_in - 1 downto down_index);
                limit_out(down_index + width_in - 1 downto down_index) <= pcm_in;
            end if;
        end if;
    end process;


end Behavioral;
