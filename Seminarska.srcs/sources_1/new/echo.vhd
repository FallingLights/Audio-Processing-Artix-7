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
        width_top : integer := 7;
        num_echo_top : integer := 5);
    Port (
        clk : in std_logic;
        new_sample : in std_logic;
        enable : in std_logic_vector (13 downto 0);
        pcm_in : in std_logic_vector (width_top-1 downto 0);
        pcm_out : out std_logic_vector (width_top-1 downto 0));
end echo;

architecture Behavioral of echo is

    component echo_process_data is
        generic(
            width : integer := 7;
            num_echo: integer := 5);
        port(
            clk : in std_logic;
            new_sample : in std_logic;
            en_sample : in std_logic;
            pcm_in : in std_logic_vector (width-1 downto 0);
            pcm_echo : out std_logic_vector (width-1 downto 0));
    end component;

    component addition_of_pcms is
        generic(
            width : integer := 7);
        port(
            clk : in std_logic;
            new_sample : in std_logic;
            sample_enable : in std_logic_vector (13 downto 0);
            pcm_in : in std_logic_vector (width-1 downto 0);
            pcm_echo : in std_logic_vector (width-1 downto 0);
            pcm_sum : out std_logic_vector (width-1 downto 0));
    end component;

    signal pcm_of_echo : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_of_sum : std_logic_vector (width_top-1 downto 0) := (others => '0');

begin

    -- dobim ven pcm_echo
    get_pcm_of_echo : echo_process_data
        generic map(
            width => width_top,
            num_echo => num_echo_top)
        port map(
            clk => clk,
            new_sample => new_sample,
            en_sample => enable(13),
            pcm_in => pcm_in,
            pcm_echo => pcm_of_echo);

    -- tukaj sestejemo pcm sample with pcm echo
    get_pcm_sum : addition_of_pcms
        generic map(
            width => width_top)
        port map(
            clk => clk,
            new_sample => new_sample,
            sample_enable => enable,
            pcm_in => pcm_in,
            pcm_echo => pcm_of_echo,
            pcm_sum => pcm_of_sum);

    -- nakoncu se napisemo pcm_sum
    pcm_out <= pcm_of_sum;

end Behavioral;
