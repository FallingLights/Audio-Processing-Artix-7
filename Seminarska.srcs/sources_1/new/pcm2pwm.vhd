----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2021 01:52:17
-- Design Name: 
-- Module Name: pcm2pwm - Behavioral
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

entity pcm2pwm is
    Generic (
        width : integer := 8;
        limit : integer := 128);
    Port (
        clk : in std_logic;
        new_sample : in std_logic;
        enable_dec : in std_logic;
        pcm : in std_logic_vector (width-1 downto 0);
        pwm : out std_logic);
end pcm2pwm;

architecture Behavioral of pcm2pwm is

    signal counter : unsigned (width-1 downto 0) := (others => '0');

begin

    process (clk)
    begin
        if clk'event and clk = '1' then
            if enable_dec = '1' then
                if unsigned(pcm) > counter then
                    pwm <= '1';
                else
                    pwm <= '0';
                end if;

                if counter = limit - 1 or new_sample = '1' then
                    counter <= (others => '0');
                else
                    counter <= counter + 1;
                end if;
            else
                counter <= (others => '0');
                pwm <= '1';
            end if;

        end if;
    end process;

end Behavioral;
