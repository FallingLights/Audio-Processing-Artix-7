----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2021 09:52:24
-- Design Name: 
-- Module Name: prescaler - Behavioral
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

entity prescaler_for_tb is
    Generic (
        freq : integer := 2400);
    Port (
        clk : in std_logic;
        rst : in std_logic;

        clk_new : out std_logic;
        clk_event : out std_logic;

        clk_rising_edge : out std_logic);
end prescaler_for_tb;

architecture Behavioral of prescaler_for_tb is

    signal count : integer range 0 to 5000 := 0;
    signal clk_out : std_logic := '0';
begin

    process(clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then -- reset event
                count <= 0;
                clk_new <= '0';
                clk_event <= '0';
                clk_rising_edge <= '0';
            else -- normalno delovanje
--                if count = (((100*1000)/(freq*2))-1) then
--                    count <= 0;
--                    clk_new <= not clk_new;
--                    clk_event <= '1';
--                    if clk_new = '0' then
--                        clk_rising_edge <= '1';
--                    else
--                        clk_rising_edge <= '0';
--                    end if;
--                else
--                    count <= count + 1;
--                    clk_event <= '0';
--                    clk_rising_edge <= '0';
--                end if;
                
                -- TEST
                if count = (((100*1000)/(freq*2))-1) then 
                    count <= 0;
                    clk_out <= not clk_out;
                    clk_event <= '1';
                    if clk_out = '0' then
                        clk_rising_edge <= '1';
                    else
                        clk_rising_edge <= '0';
                    end if;
                else
                    count <= count + 1;
                    clk_event <= '0';
                    clk_rising_edge <= '0';
                end if;
                clk_new <= clk_out;   
                
            end if;
        end if; -- rst = '1'
    end process;

end Behavioral;
