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
        rst : in std_logic;
        
        new_sample : in std_logic;
        SW : in std_logic_vector (15 downto 0);
        pcm_in : in std_logic_vector (width_top-1 downto 0);
        
        LED : out std_logic_vector (15 downto 0);
        pcm_out : out std_logic_vector (width_top-1 downto 0));
end echo;

architecture Behavioral of echo is

    signal pcm_of_echo : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_of_sum : std_logic_vector (width_top-1 downto 0) := (others => '0');
    
    signal pcm_in_addition : std_logic_vector (width_top-1 downto 0);
    signal pcm_echo_addition : std_logic_vector (width_top-1 downto 0) := (others => '0');
    
    signal pcm_out_final : std_logic_vector (width_top-1 downto 0);
begin

    -- dobim ven pcm_echo
    get_pcm_of_echo : entity work.echo_process_data
        generic map(
            width => width_top,
            num_echo => num_echo_top)
        port map(
            clk => clk,
            rst => rst,
            new_sample => new_sample,
            SW => SW(15 downto 0),
            pcm_in => pcm_in,
            
            pcm_echo => pcm_of_echo);
    
    process (clk)
    begin
    if (rising_edge(clk)) then
      if SW(11) = '1' then --echo
        LED(11) <= '1';
        pcm_in_addition <= pcm_in;
        pcm_echo_addition <= pcm_of_echo;
      else -- inverse echo
        LED(11) <= '0';
        pcm_in_addition <= pcm_of_echo;
        pcm_echo_addition <= pcm_in;
      end if;
    end if;
    end process;
    -- tukaj sestejemo pcm sample with pcm echo
    get_pcm_out : entity work.addition_of_pcms
        generic map(
            width => width_top)
        port map(
            clk => clk,
            rst => rst,
            
            new_sample => new_sample,
            
            pcm_in => pcm_in_addition,
            pcm_echo => pcm_echo_addition,
            
            pcm_out => pcm_of_sum);
       
       process (clk) 
        begin
        if (rising_edge(clk)) then
          if SW(12) = '1' then
            LED(12) <= '1';
            pcm_out_final <= pcm_of_sum;
          else
            LED(12) <= '0';
            pcm_out_final <= pcm_of_echo;
          end if;
        end if;
        end process;
    
    -- nakoncu se napisemo pcm_out
    pcm_out <= pcm_out_final;

end Behavioral;
