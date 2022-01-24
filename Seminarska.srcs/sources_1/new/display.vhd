----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2022 06:24:30
-- Design Name: 
-- Module Name: vol_display - Behavioral
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

entity display is
    Port ( clk : in std_logic;
           delay : in unsigned (4 downto 0);
           vol : in unsigned (2 downto 0);
           an : out std_logic_vector (7 downto 0);
           cath : out std_logic_vector (7 downto 0));
end display;

architecture Behavioral of display is

    component anode_prescaler is
        Generic ( limit : integer := 100000);
        Port ( clk : in std_logic;
               enable : out std_logic);
    end component;

    component anode_switcher is
        Port ( clk : in std_logic;
               enable : in std_logic;
               anode : out std_logic_vector (7 downto 0));
    end component;

    component digit2segments is
        Port ( digit : in std_logic_vector (3 downto 0);
               cathode : out std_logic_vector (7 downto 0));
    end component;
    
    signal enable_an : std_logic;
    signal an_internal : std_logic_vector (7 downto 0);
    signal digit : unsigned (3 downto 0);

begin

    an_pr : anode_prescaler
        port map ( clk => clk,
                   enable => enable_an);

    an_sw : anode_switcher
        port map ( clk => clk,
                   enable => enable_an,
                   anode => an_internal);

    digit_to_segments : digit2segments
        port map ( digit => std_logic_vector(digit),
                   cathode => cath);

    with an_internal select
        digit <= '0' & vol when "11111110",
                 delay(3 downto 0) when "11101111",
                 "000" & delay(4) when "11011111",
                 "0000" when others;
    
    an <= std_logic_vector(an_internal);

end Behavioral;
