----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2022 16:02:34
-- Design Name: 
-- Module Name: echo_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;


entity echo_tb is
--  Port ( );
end echo_tb;

architecture Behavioral of echo_tb is
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    
    signal clk_2400khz : std_logic; -- := '1';
    signal rising_edge_2400khz : std_logic; -- := '1';
    
    signal clk_12khz : std_logic; -- := '0';
    signal event_12khz : std_logic; -- := '0';
    
    signal pdm : std_logic := '0';
    signal pcm : std_logic_vector (17 downto 0) := (others => '0');
    signal pcm_filtered : std_logic_vector (17 downto 0) := (others => '0');
    
    signal delay : std_logic_vector (17 downto 0) := "000001100001101010";
    
    signal LED: std_logic_vector (12 downto 0) := (others => '0');
    signal data_pdm_temp : integer;
begin
    microphone_clock : entity work.prescaler
        generic map(
            freq => 2400)
        port map(
            clk => clk,
            rst => rst,
            clk_new => clk_2400khz,
            clk_rising_edge => rising_edge_2400khz);

    sampling_period : entity work.prescaler
        generic map(
            freq => 12)
        port map(
            clk => clk,
            rst => rst,
            clk_new => clk_12khz,
            clk_event => event_12khz);
            
    pdm_to_pcm : entity work.pdm2pcm
        generic map(
            width => 18,
            limit => 262143)
        port map(
            clk => clk,
            rst => rst,
            clk_sample => clk_12khz,
            event_sample => event_12khz,
            m_enable => rising_edge_2400khz,
            m_data => pdm,
            pcm => pcm);
            
    filter : entity work.median_filter
        generic map(
            width => 18,
            window => 3)
        port map(
            clk => clk,
            rst => rst,
            new_sample => event_12khz,
            pcm_in => pcm,
            pcm_out => pcm_filtered);
            
            
    -- max num_echo_top => 150000
    echo_effect : entity work.echo
        generic map (
            width_top => 18)
        port map(
            clk => clk,
            rst => rst,
            num_echo_top => delay,
            new_sample => event_12khz,
            SW => SW(12 downto 1),
            LED => LED(12 downto 1),
            pcm_in => pcm_filtered,
            pcm_out => pcm_echoed);
                      
    -- microphone
    process
        variable ana,a,acc : real;
    begin
        a := 0.0;
        acc := 0.0;
        data_pdm_temp <= 0;
        loop
            wait until rising_edge_2400khz = '1' and rising_edge(clk);
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