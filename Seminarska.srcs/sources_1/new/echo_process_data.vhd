----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2022 22:19:29
-- Design Name: 
-- Module Name: echo_process_data - Behavioral
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

entity echo_process_data is
    Generic (
        width : integer := 7;
        num_echo: integer := 5);
    Port (
        clk : in std_logic;
        new_sample : in std_logic;
        enable : in std_logic_vector (14 downto 0);
        pcm_in : in std_logic_vector (width-1 downto 0);
        pcm_echo : out std_logic_vector (width-1 downto 0));
end echo_process_data;

architecture Behavioral of echo_process_data is

    component bram_wrapper is
        port (
            BRAM_PORTA_0_addr : in STD_LOGIC_VECTOR ( 31 downto 0 );
            BRAM_PORTA_0_clk : in STD_LOGIC;
            BRAM_PORTA_0_din : in STD_LOGIC_VECTOR ( 31 downto 0 );
            BRAM_PORTA_0_dout : out STD_LOGIC_VECTOR ( 31 downto 0 );
            BRAM_PORTA_0_en : in STD_LOGIC;
            BRAM_PORTA_0_rst : in STD_LOGIC;
            BRAM_PORTA_0_we : in STD_LOGIC_VECTOR ( 3 downto 0 )
        );
    end component;

    signal count : integer range 0 to num_echo := 0;
    signal ix : integer range 0 to num_echo*width := 0;
    signal buff : std_logic_vector (num_echo*width-1 downto 0) := (others => '0');


    signal pcm_temp : std_logic_vector (31 downto 0) := (others => '0');
    signal pcm_in_temp : unsigned (31 downto 0) := (others => '0');
    signal count_temp : unsigned  (31 downto 0) := (others => '0');

    signal bram_enable : std_logic := '0';
    signal bram_wet : std_logic_vector(3 downto 0) := (others => '0');

begin
    process(clk)
    begin

        if clk'event and clk = '1' then
            if enable(14)= '1' then
                count_temp <= (others => '0');
                bram_wet <= "0000";
                bram_enable <= '0';
                
            elsif new_sample = '1' then
                bram_enable <= '1';
                if enable(13) = '1' then
                    bram_wet <= "0000";
                else
                    bram_wet <= "1111";

                    pcm_in_temp <= (others => '0');
                    pcm_in_temp <= pcm_in_temp + unsigned (pcm_in);
                end if;
                if count_temp = num_echo-1 then
                    count_temp <= (others => '0');
                else
                    count_temp <= count_temp + 1;
                end if;
            else
                bram_enable <= '0';
                bram_wet <= "0000";
            end if;
        end if;
    end process;
    
-- READ FIRST more biti
    get_pcm_into_ram : bram_wrapper
        port map(
            BRAM_PORTA_0_addr => std_logic_vector (count_temp),
            BRAM_PORTA_0_clk => clk,
            BRAM_PORTA_0_din => std_logic_vector(pcm_in_temp),
            BRAM_PORTA_0_dout => pcm_temp,
            BRAM_PORTA_0_en => bram_enable,
            BRAM_PORTA_0_rst => enable(14),
            BRAM_PORTA_0_we => bram_wet
        );

    process(clk)
    begin
        if clk'event and clk = '1' then
            if enable(14) = '1' then
                pcm_echo <= (others => '0');
                
            elsif new_sample = '1' then
                pcm_echo <= pcm_temp(width-1 downto 0);
            end if;
        end if;
    end process;



end Behavioral;
