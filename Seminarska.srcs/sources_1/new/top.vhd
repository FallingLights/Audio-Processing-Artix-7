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
          m_data : in  std_logic; -- bit iz mikrofona
          m_lrsel : out std_logic;
          aud_pwm : out std_logic; -- audio izhod
          aud_sd : out std_logic); -- omogoci audio izhod
end top;

architecture Behavioral of top is

-- delilnik ure
component prescaler is
    port(
        clk : in std_logic;
        clk_new : inout std_logic;
        enable : out std_logic);
end component;

signal clk_new : std_logic := '1';
signal enable : std_logic;

begin

pr : prescaler
    port map(
        clk => clk,
        clk_new => clk_new,
        enable => enable);

m_clk <= clk_new; -- ura za mikrofon
m_lrsel <= '0'; -- bit iz mikrofona je na voljo ob pozitivni fronti ure

-- aud_sd <= '1'
-- aud_pwm <= m_data;

end Behavioral;
