----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.01.2022 19:47:24
-- Design Name: 
-- Module Name: prescaler_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prescaler_tb is
--  Port ( );
end prescaler_tb;

architecture Behavioral of prescaler_tb is
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    
    signal clk_2400khz : std_logic := '1';
    signal enable_2400khz : std_logic := '1';
    
    signal clk_12khz : std_logic := '0';
    signal enable_12khz : std_logic := '0';
begin
    
    microphone_clock : entity work.prescaler
        generic map(
            freq => 2400)
        port map(
            clk => clk,
            rst => rst,
            clk_new => clk_2400khz,
            clk_rising_edge => enable_2400khz);

    sampling_period : entity work.prescaler
        generic map(
            freq => 12)
        port map(
            clk => clk,
            rst => rst,
            clk_new => clk_12khz,
            clk_event => enable_12khz);
    
    process
    begin
        clk <= '0';
        loop
            wait for 10 ns;
            clk <= '1', '0' after 5 ns;
        end loop;
    end process;
    
    
     process
    begin
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        
        for i in 0 to 3000000 loop
            
            wait until rising_edge(clk); wait for 1 ns;

        end loop;
        rst <= '1';
        wait for 100 ns;
        rst <= '0'; 
        wait for 100 ms;

        assert (false) report  "Konec Simulacije" severity failure;

    end process;
end Behavioral;
