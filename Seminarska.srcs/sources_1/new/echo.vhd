----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2022 21:25:56
-- Design Name: 
-- Module Name: echo - Behavioral
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

entity echo is
    Generic (
        width_top : integer := 8;
        limit_top : integer := 128;
        num_echo: integer := 5);
    Port (
        clk : in std_logic;
        event_sample : in std_logic;
        ECHO : in std_logic;
        pcm_in : in std_logic_vector (width_top - 1 downto 0);
        pcm_out : out std_logic_vector (width_top - 1 downto 0));
end echo;

architecture Behavioral of echo is

    component echo_process_data is
        generic(
            width_in : integer := 8;
            limit_in : integer := 128;
            width_num : integer := 4;
            num_echo: integer := 5);
        port(
            clk : in std_logic;
            event_sample : in std_logic;
            pcm_in : in std_logic_vector (width_in - 1 downto 0);
            pcm_echo : out std_logic_vector (width_in - 1 downto 0));
    end component;

    component addition_of_pcms is
        generic(
            width_in : integer := 8;
            limit_in : integer := 128);
        port(
            clk : in std_logic;
            event_sample : in std_logic;
            echo : in std_logic;
            pcm_in : in std_logic_vector (width_in - 1 downto 0);
            pcm_echo : in std_logic_vector (width_in - 1 downto 0);
            pcm_sum : out std_logic_vector (width_in - 1 downto 0));
    end component;

    signal pcm_of_echo : std_logic_vector (width_top - 1 downto 0) := (others => '0');
    signal pcm_of_sum : std_logic_vector (width_top - 1 downto 0) := (others => '0');

begin

    -- dobim ven pcm_echo
    get_pcm_of_echo : echo_process_data
        generic map(
            width_in => width_top,
            limit_in => limit_top,
            width_num => 4,
            num_echo => 5)
        port map(
            clk => clk,
            event_sample => event_sample,
            pcm_in => pcm_in,
            pcm_echo => pcm_of_echo);

    -- tukaj sestejemo pcm sample with pcm echo
    get_pcm_sum : addition_of_pcms
        generic map(
            width_in => width_top,
            limit_in => limit_top)
        port map(
            clk => clk,
            event_sample => event_sample,
            echo => ECHO,
            pcm_in => pcm_in,
            pcm_echo => pcm_of_echo,
            pcm_sum => pcm_of_sum);

    -- nakoncu se napisemo pcm_sum
    pcm_out <= pcm_of_sum;

end Behavioral;
