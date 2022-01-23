----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.01.2022 20:22:50
-- Design Name: 
-- Module Name: pdm2pcm_tb - Behavioral
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
use ieee.math_real.all;

entity pdm2pcm_tb is
--  Port ( );
end pdm2pcm_tb;

architecture Behavioral of pdm2pcm_tb is
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    
    signal clk_2400khz : std_logic := '1';
    signal enable_2400khz : std_logic := '1';
    
    signal clk_12khz : std_logic := '0';
    signal enable_12khz : std_logic := '0';
    
    signal pdm : std_logic := '0';
    signal pcm : std_logic_vector (17 downto 0) := (others => '0');
    
    signal data_pdm_temp : integer;
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
            
    pdm_to_pcm : entity work.pdm2pcm
        generic map(
            width => 18,
            limit => 262143)
        port map(
            clk => clk,
            rst => rst,
            clk_sample => clk_12khz,
            event_sample => enable_12khz,
            m_enable => enable_2400khz,
            m_data => pdm,
            pcm => pcm);
            
    -- microphone
    process
        variable ana,a,acc : real;
    begin
        a := 0.0;
        acc := 0.0;
        data_pdm_temp <= 0;
        loop
            wait until enable_2400khz = '1' and rising_edge(clk);
            a:=a+2.0*MATH_PI*10000.0/2500000.0;
            ana:=0.9*SIN(a);
            acc:=acc+ana;
            if acc>=0.0 then
                pdm <= '1';
                acc:=acc - (+1.0);
            else
                pdm <= '0';
                acc:=acc - (-1.0);
            end if;
            data_pdm_temp <= integer(ROUND(1000.0*ana));
        end loop;
    end process;
            
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
        
        wait until clk'event and clk='1'; wait for 1 ns;

        wait for 60 us;
        wait for 500 us;
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 3000 us;


        wait for 100 ns;

        assert (false) report  "Konec Simulacije" severity failure;

    end process;
end Behavioral;
