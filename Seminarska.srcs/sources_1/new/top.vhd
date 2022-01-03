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
    Port( clk : in  std_logic;
          m_clk : out std_logic; -- ura za mikrofon
          m_data : in  std_logic; -- vhod iz mikrofona
          m_lrsel : out std_logic;
          aud_pwm : out std_logic; -- audio izhod
          aud_sd : out std_logic); -- omogoci audio izhod
end top;

architecture Behavioral of top is

-- delilnik ure
component prescaler is
    generic(
        width : integer := 6;
        limit : integer := 42);
    port(
        clk : in std_logic;
        clk_new : inout std_logic;
        event : out std_logic;
        enable : out std_logic);
end component;

component pdm2pcm is
    generic(
        width : integer := 8;
        limit : integer := 128);
    port(
        clk : in std_logic;
        clk_sample : in std_logic;
        event_sample : in std_logic;
        m_enable : in std_logic;
        m_data : in std_logic;
        pcm : out std_logic_vector (width-1 downto 0));
end component;

component pcm2pwm is
    generic(
        width : integer := 8;
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

signal pcm : std_logic_vector (7 downto 0) := (others => '0');

begin

microphone_clock : prescaler
    generic map(
        width => 6,
        limit => 42)
    port map(
        clk => clk,
        clk_new => clk_2400khz,
        enable => rising_edge_2400khz);

sampling_period : prescaler
    generic map(
        width => 14,
        limit => 8333)
    port map(
        clk => clk,
        clk_new => clk_12khz,
        event => event_12khz);

pdm_to_pcm : pdm2pcm
    port map(
        clk => clk,
        clk_sample => clk_12khz,
        event_sample => event_12khz,
        m_enable => rising_edge_2400khz,
        m_data => m_data,
        pcm => pcm);

pcm_to_pwm : pcm2pwm
    port map(
        clk => clk,
        new_sample => event_12khz,
        pcm => pcm,
        pwm => aud_pwm);

m_clk <= clk_2400khz;
m_lrsel <= '0'; -- bit iz mikrofona je na voljo ob pozitivni fronti ure
aud_sd <= '1';

end Behavioral;
