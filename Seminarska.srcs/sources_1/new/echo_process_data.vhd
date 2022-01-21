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

    component frame_bram is
        port (
            clka : IN STD_LOGIC;
            wea : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            addra : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
            dina : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
            clkb : IN STD_LOGIC;
            enb : IN STD_LOGIC;
            addrb : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
            doutb : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
        );
    END component;

    signal count : integer range 0 to num_echo := 0;
    signal ix : integer range 0 to num_echo*width := 0;
    signal buff : std_logic_vector (num_echo*width-1 downto 0) := (others => '0');


    signal pcm_temp : std_logic_vector (31 downto 0) := (others => '0');
    signal pcm_in_temp : unsigned (31 downto 0) := (others => '0');
    signal count_temp : unsigned  (31 downto 0) := (others => '0');

    signal bram_enable : std_logic := '0';
    signal bram_wet : std_logic_vector(1 downto 0) := (others => '0');

begin
    process(clk)
    begin

        if clk'event and clk = '1' then
            if enable(14)= '1' then
                count_temp <= (others => '0');
                bram_wet <= "00";
                bram_enable <= '0';

            elsif new_sample = '1' then
                bram_enable <= '1';
                if enable(13) = '1' then
                    bram_wet <= "00";
                else
                    bram_wet <= "11";

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
                bram_wet <= "00";
            end if;
        end if;
    end process;

    -- READ FIRST more biti
    
    get_pcm_into_ram : frame_bram
        port map(
            clka => clk,
            wea => bram_wet,
            addra => std_logic_vector (count_temp),
            dina => pcm_in,
            clkb => clk,
            enb => bram_enable,
            addrb => std_logic_vector (count_temp),
            doutb => pcm_temp
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
