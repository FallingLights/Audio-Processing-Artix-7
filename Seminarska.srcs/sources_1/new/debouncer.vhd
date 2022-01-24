----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2022 08:18:24
-- Design Name: 
-- Module Name: debouncer - Behavioral
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

entity debouncer is
    Port (
        clk : in std_logic;
        BTNU : in std_logic;
        BTNL : in std_logic;
        BTNR : in std_logic;
        BTND : in std_logic;
        BTNU_db : out std_logic;
        BTNL_db : out std_logic;
        BTNR_db : out std_logic;
        BTND_db : out std_logic);
end debouncer;

architecture Behavioral of debouncer is

    component btn_debounce is
        Port ( clk : in std_logic;
               btn_in : in std_logic;
               btn_out : out std_logic);
    end component;

begin

    BTNU_debounce : btn_debounce
        port map(
            clk => clk,
            btn_in => BTNU,
            btn_out => BTNU_db);

    BTNL_debounce : btn_debounce
        port map(
            clk => clk,
            btn_in => BTNL,
            btn_out => BTNL_db);

    BTNR_debounce : btn_debounce
        port map(
            clk => clk,
            btn_in => BTNR,
            btn_out => BTNR_db);

    BTND_debounce : btn_debounce
        port map(
            clk => clk,
            btn_in => BTND,
            btn_out => BTND_db);
	
end Behavioral;
