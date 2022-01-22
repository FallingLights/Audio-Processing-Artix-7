----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2021 05:19:55
-- Design Name: 
-- Module Name: top - Behavioral
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
-- 0 -> ON = Reset?      8 ->
-- 1 ->                  9 ->
-- 2 ->                  10 ->
-- 3 ->                  11 -> ON = ECHO | OFF = Inverse ECHO
-- 4 ->                  12 -> ON = ECHO_ADDITION | OFF = samo BRAM
-- 5 ->                  13 -> ON = Shranuje v BRAM
-- 6 ->                  14 -> ON = ECHO MODULE | OFF = BYPASS ECHO
-- 7 ->                  15 -> ON = OBDELOVANJE SIGNALA | OFF = DIREKTNO IZ MIC
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Generic (
        width_top : integer := 18;
        limit_top : integer := 262143);
    Port ( 
        clk : in  std_logic;
        CPU_RESETN : in std_logic;
        
        -- Microphone
        m_clk : out std_logic; -- ura za mikrofon
        m_data : in  std_logic; -- vhod iz mikrofona
        
        -- I/O
        SW : in std_logic_vector (15 downto 0);
        LED : out std_logic_vector (15 downto 0);
        
        --Audio Out
        m_lrsel : out std_logic;
        aud_pwm : out std_logic; -- audio izhod
        aud_sd : out std_logic); -- omogoci audio izhod
end top;

architecture Behavioral of top is

    signal clk_2400khz : std_logic := '1';
    signal rising_edge_2400khz : std_logic;
    
    signal clk_12khz : std_logic := '0';
    signal event_12khz : std_logic;
    
    signal pcm : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_filtered : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_decimated : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_echoed : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pwm : std_logic;
    signal pcm_in_pcm2pwm : std_logic_vector (width_top-1 downto 0) := (others => '0');
    
    signal rst : std_logic;

begin
    --rst <= CPU_RESETN;
    
    process(clk)
    begin
        if rising_edge(clk) then
          rst <= CPU_RESETN;
        end if;
    end process;
    
    microphone_clock : entity work.prescaler
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
            width => width_top,
            limit => limit_top)
        port map(
            clk => clk,
            rst => rst,
            clk_sample => clk_12khz,
            event_sample => event_12khz,
            m_enable => rising_edge_2400khz,
            m_data => m_data,
            pcm => pcm);

    filter : entity work.median_filter
        generic map(
            width => width_top,
            window => 3)
        port map(
            clk => clk,
            rst => rst,
            new_sample => event_12khz,
            pcm_in => pcm,
            pcm_out => pcm_filtered);
            
    decimation_of_pcm : entity work.decimation
        generic map (
            width_pcm => width_top,
            limit_dec => 3)
        port map(
            clk => clk,
            rst => rst,
            new_sample => event_12khz,
            pcm_in => pcm_filtered,
            pcm_out => pcm_decimated);

-- max num_echo_top => 150000
    echo_effect : entity work.echo
        generic map (
            width_top => width_top,
            num_echo_top => 5)
        port map(
            clk => clk,
            rst => rst,
            new_sample => event_12khz,
            SW => SW(13 downto 0),
            LED => LED(13 downto 0),
            pcm_in => pcm_filtered,
            pcm_out => pcm_echoed);
    
    process(clk)
    begin
        if rising_edge(clk) then
            if SW(14) = '1' then
                LED(14) <= '1';
                pcm_in_pcm2pwm <= pcm_echoed;
            else
                LED(14) <= '0';
                pcm_in_pcm2pwm <= pcm_filtered;
            end if;
        end if;
    end process;
    
    pcm_to_pwm : entity work.pcm2pwm
        generic map(
            width => width_top,
            limit => limit_top)
        port map(
            clk => clk,
            rst => rst,
            new_sample => event_12khz,
            pcm => pcm_in_pcm2pwm, 
            pwm => pwm);
    
    process(clk)
    begin
    if rising_edge(clk) then
        if SW(15) = '1' then
            LED(15) <= '1';
            aud_pwm <= pwm;
        else
            LED(15) <= '0';
            aud_pwm <= m_data;
        end if;
    end if;
    end process;
    
    m_clk <= clk_2400khz;
    m_lrsel <= '0'; -- bit iz mikrofona je na voljo ob pozitivni fronti ure
    aud_sd <= '1';
end Behavioral;
