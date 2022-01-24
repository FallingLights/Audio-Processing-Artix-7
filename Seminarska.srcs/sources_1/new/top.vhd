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
-- 0 -> ON = Reset?      8 ->
-- 1 ->                  9 ->
-- 2 ->                  10 ->  ON = ECHO | OFF = Inverse ECHO
-- 3 ->                  11 -> ON = ECHO_ADDITION | OFF = samo BRAM (delay)
-- 4 ->                  12 -> OFF = Shranuje v BRAM
-- 5 ->                  13 -> ON = ECHO MODULE | OFF = BYPASS ECHO
-- 6 ->                  14 -> 
-- 7 ->                  15 -> ON = OBDELOVANJE SIGNALA | OFF = DIREKTNO IZ MIC
-- BTNU -> volume up     BTND -> volume down (0->5, default je 3)
-- BTNR -> +6250 delay   BTNL -> -6250 delay (1-24, default je 1: 6250=0.25s)
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Generic (
        width_top : integer := 18;
        limit_top : integer := 262143);
    Port (
        clk : in  std_logic;
        CPU_RESETN : in std_logic;

        -- Microphone
        m_data : in  std_logic; -- vhod iz mikrofona

        m_clk : out std_logic; -- ura za mikrofon
        
        -- I/O
        SW : in std_logic_vector (15 downto 0);
        BTNU : in std_logic;
        BTNL : in std_logic;
        BTNR : in std_logic;
        BTND : in std_logic;
        
        LED : out std_logic_vector (15 downto 0);
        cath : out std_logic_vector (7 downto 0);
        an : out std_logic_vector (7 downto 0);

        --Audio Out
        m_lrsel : out std_logic;
        aud_pwm : out std_logic; -- audio izhod
        aud_sd : out std_logic); -- omogoci audio izhod
end top;

architecture Behavioral of top is

--    component debouncer is
--        Port ( clk : in std_logic;
--               BTNU : in std_logic;
--               BTNL : in std_logic;
--               BTNR : in std_logic;
--               BTND : in std_logic;
--               BTNU_db : out std_logic;
--               BTNL_db : out std_logic;
--               BTNR_db : out std_logic;
--               BTND_db : out std_logic);
--    end component;

--    component display is
--        Port ( clk : in std_logic;
--               delay : in unsigned (4 downto 0);
--               vol : in unsigned (2 downto 0);
--               an : out std_logic_vector (7 downto 0);
--               cath : out std_logic_vector (7 downto 0));
--    end component;

    signal clk_2400khz : std_logic := '1';
    signal event_2400khz : std_logic;

    signal clk_12khz : std_logic := '0';
    signal event_12khz : std_logic;

    signal pcm : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_filtered : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_echoed : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pwm : std_logic;
    signal pcm_in_pcm2pwm : std_logic_vector (width_top-1 downto 0) := (others => '0');
    signal pcm_vol : unsigned (width_top-1 downto 0) := (others => '0');
    signal rst : std_logic := '0';
    signal audioOut : std_logic := '0';
    
    signal BTNU_db : std_logic := '0';
    signal BTNL_db : std_logic := '0';
    signal BTNR_db : std_logic := '0';
    signal BTND_db : std_logic := '0';
    
    signal BTNU_prev : std_logic := '0';
    signal BTNL_prev : std_logic := '0';
    signal BTNR_prev : std_logic := '0';
    signal BTND_prev : std_logic := '0';
    signal vol : integer range -3 to 2 := 0;
    signal vol_val : unsigned (2 downto 0) := "011";
    signal delay : std_logic_vector (17 downto 0) := "000001100001101010";
    signal delay_val : unsigned (4 downto 0) := "00001";

begin

    button_debouncing : entity work.debouncer
        port map (
            clk => clk,
            BTNU => BTNU,
            BTNL => BTNL,
            BTNR => BTNR,
            BTND => BTND,
            BTNU_db => BTNU_db,
            BTNL_db => BTNL_db,
            BTNR_db => BTNR_db,
            BTND_db => BTND_db);

    rst <= SW(0);
    
    process(clk) --Reset
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                LED(0) <= '1';
            else
                LED(0) <= '0';
            end if;
        end if;
    end process;
    
    microphone_clock : entity work.prescaler
        port map(
            clk => clk,
            rst => rst,
            clk_new => clk_2400khz,
            clk_rising_edge => event_2400khz);

    sampling_period : entity work.prescaler
        generic map(
            freq => 12)
        port map(
            clk => clk,
            rst => rst,
            clk_new => clk_12khz,
            clk_event => event_12khz);

    pdm_to_pcm : entity work.pdm2pcm
        generic map(
            width => width_top,
            limit => limit_top)
        port map(
            clk => clk,
            rst => rst,
            clk_sample => clk_12khz,
            event_sample => event_12khz,
            m_enable => event_2400khz,
            m_data => m_data,
            pcm => pcm);

    filter : entity work.median_filter
        generic map(
            width => width_top,
            window => 3)
        port map(
            clk => clk,
            rst => rst,
            new_sample => event_12khz,
            pcm_in => pcm,
            pcm_out => pcm_filtered);

    delay_control : process(clk)
    begin
        if clk'event and clk = '1' then
            if BTNR_db = '1' and BTNR_prev = '0' then
                if delay < 150000 then
                    delay <= delay + 6250;
                    delay_val <= delay_val + 1;
                end if;
            elsif BTNL_db = '1' and BTNL_prev = '0' then
                if delay > 6250 then
                    delay <= delay - 6250;
                    delay_val <= delay_val - 1;
                end if;
            end if;
            BTNR_prev <= BTNR_db;
            BTNL_prev <= BTNL_db;
        end if;
    end process;

    -- max num_echo_top => 150000
    echo_effect : entity work.echo
        generic map (
            width_top => width_top)
        port map(
            clk => clk,
            rst => rst,
            num_echo_top => delay,
            new_sample => event_12khz,
            SW => SW(12 downto 1),
            LED => LED(12 downto 1),
            pcm_in => pcm_filtered,
            pcm_out => pcm_echoed);

    process(clk)
    begin
        if clk'event and clk = '1' then
            if SW(13) = '1' then
                LED(13) <= '1';
                pcm_in_pcm2pwm <= pcm_echoed;
            else
                LED(13) <= '0';
                pcm_in_pcm2pwm <= pcm_filtered;
            end if;
        end if;
    end process;
    
    volume_control : process(clk)
    begin
        if clk'event and clk = '1' then
            if BTNU_db = '1' and BTNU_prev = '0' then
                if vol < 2 then
                    vol <= vol + 1;
                    vol_val <= vol_val + 1;
                end if;
            elsif BTND_db = '1' and BTND_prev = '0' then
                if vol > -3 then
                    vol <= vol - 1;
                    vol_val <= vol_val - 1;
                end if;
            end if;
            BTNU_prev <= BTNU_db;
            BTND_prev <= BTND_db;
            if vol < 0 then
                pcm_vol <= shift_right(unsigned(pcm_in_pcm2pwm), -vol);
            elsif vol > 0 then
                pcm_vol <= shift_left(unsigned(pcm_in_pcm2pwm), vol);
            else
                pcm_vol <= unsigned(pcm_in_pcm2pwm);
            end if;
        end if;
    end process;

    pcm_to_pwm : entity work.pcm2pwm
        generic map(
            width => width_top,
            limit => limit_top)
        port map(
            clk => clk,
            rst => rst,
            new_sample => event_12khz,
            pcm => std_logic_vector(pcm_vol),
            pwm => pwm);
    
    volume_and_delay_display : entity work.display
        port map(
            clk => clk,
            delay => delay_val,
            vol => vol_val,
            cath => cath,
            an => an (7 downto 0));

    process(clk)
    begin
        if clk'event and clk = '1' then
            if SW(15) = '1' then
                LED(15) <= '1';
                audioOut <= pwm;
            else
                LED(15) <= '0';
                audioOut <= m_data;
            end if;
            aud_pwm <= audioOut;
        end if;
    end process;

    m_clk <= clk_2400khz;
    m_lrsel <= '0'; -- bit iz mikrofona je na voljo ob pozitivni fronti ure
    aud_sd <= '1';
end Behavioral;
