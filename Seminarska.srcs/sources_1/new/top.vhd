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
-- 
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
        width_top : integer := 7;
        limit_top : integer := 128);
    Port ( 
        clk : in  std_logic;
        m_clk : out std_logic; -- ura za mikrofon
        m_data : in  std_logic; -- vhod iz mikrofona
        echo_enable : in std_logic; -- prvi switch za dolocanje ali je echo ali ne
        sw : in std_logic; -- drugi switch; ce je vklopljen prihaja zvok direkt iz mikrofona
        m_lrsel : out std_logic;
        aud_pwm : out std_logic; -- audio izhod
        aud_sd : out std_logic); -- omogoci audio izhod
end top;

architecture Behavioral of top is

    -- delilnik ure
    component prescaler is
        generic(
            freq : integer := 2400); -- kHz
        port(
            clk : in std_logic;
            clk_new : inout std_logic;
            clk_event : out std_logic;
            clk_rising_edge : out std_logic);
    end component;

    component pdm2pcm is
        generic(
            width : integer := 7;
            limit : integer := 128);
        port(
            clk : in std_logic;
            clk_sample : in std_logic;
            event_sample : in std_logic;
            m_enable : in std_logic;
            m_data : in std_logic;
            pcm : out std_logic_vector (width-1 downto 0));
    end component;
    
    component boxcar_filter is
        generic(
            width : integer := 7;
            window : integer := 7);
        port(
            clk : in std_logic;
            new_sample : in std_logic;
            pcm_in : in std_logic_vector (width-1 downto 0);
            pcm_out : inout std_logic_vector (width-1 downto 0));
    end component;
    
    component decimation is
        generic(
            width_pcm : integer := 7;
            limit_dec : integer := 10);
        port(
            clk : in std_logic;
            new_sample : in std_logic;
            pcm_in : in std_logic_vector (width_pcm-1 downto 0);
            pcm_out : out std_logic_vector (width_pcm-1 downto 0));
    end component;

    component echo is
        generic(
            width_top : integer := 7;
            num_echo_top : integer := 5);
        port(
            clk : in std_logic;
            new_sample : in std_logic;
            echo_enable : in std_logic;
            pcm_in : in std_logic_vector (width_top-1 downto 0);
            pcm_out : out std_logic_vector (width_top-1 downto 0));
    end component;

    component delay is
        generic(
            width : integer := 7;
            limit : integer := 128;
            num_delay : integer := 5);
        port(
            clk : in std_logic;
            new_sample : in std_logic;
            pcm_in : in std_logic_vector (width-1 downto 0);
            pcm_delay : out std_logic_vector (width-1 downto 0));
     end component;

    component pcm2pwm is
        generic(
            width : integer := 7;
            limit : integer := 128);
        port(
            clk : in std_logic;
            new_sample : in std_logic;
            pcm : in std_logic_vector (width-1 downto 0);
            pwm : out std_logic);
    end component;

    signal clk_2400khz : std_logic := '1';
    signal rising_edge_2400khz : std_logic;
    
    signal clk_12khz : std_logic := '0';
    signal event_12khz : std_logic;
    
    signal pcm : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_filtered : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_decimated : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_echoed : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pwm : std_logic;

begin

    microphone_clock : prescaler
        port map(
            clk => clk,
            clk_new => clk_2400khz,
            clk_rising_edge => rising_edge_2400khz);

    sampling_period : prescaler
        generic map(
            freq => 12)
        port map(
            clk => clk,
            clk_new => clk_12khz,
            clk_event => event_12khz);

    pdm_to_pcm : pdm2pcm
        generic map(
            width => width_top,
            limit => limit_top)
        port map(
            clk => clk,
            clk_sample => clk_12khz,
            event_sample => event_12khz,
            m_enable => rising_edge_2400khz,
            m_data => m_data,
            pcm => pcm);

    filter : boxcar_filter
        generic map(
            width => width_top,
            window => 3)
        port map(
            clk => clk,
            new_sample => event_12khz,
            pcm_in => pcm,
            pcm_out => pcm_filtered);
            
    decimation_of_pcm : decimation
        generic map (
            width_pcm => width_top,
            limit_dec => 7)
        port map(
            clk => clk,
            new_sample => event_12khz,
            pcm_in => pcm_filtered,
            pcm_out => pcm_decimated);

    echo_effect : echo
        generic map (
            width_top => width_top,
            num_echo_top => 50)
        port map(
            clk => clk,
            new_sample => event_12khz,
            echo_enable => echo_enable,
            pcm_in => pcm_decimated,
            pcm_out => pcm_echoed);

    pcm_to_pwm : pcm2pwm
        generic map(
            width => width_top,
            limit => limit_top)
        port map(
            clk => clk,
            new_sample => event_12khz,
            pcm => pcm_echoed,
            pwm => pwm);

    m_clk <= clk_2400khz;
    m_lrsel <= '0'; -- bit iz mikrofona je na voljo ob pozitivni fronti ure
    aud_sd <= '1';
    
    process(clk)
    begin
        if sw = '1' then
            aud_pwm <= m_data;
        else
            aud_pwm <= pwm;
        end if;
    end process;

end Behavioral;
