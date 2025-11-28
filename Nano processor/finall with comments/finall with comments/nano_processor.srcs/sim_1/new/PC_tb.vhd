library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_tb is
end PC_tb;

architecture Behavioral of PC_tb is

    -- Component under test
    component PC
        Port (
            Clk          : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            En           : in  STD_LOGIC;
            PC_Current   : in  STD_LOGIC_VECTOR(2 downto 0);
            PC_Out       : out STD_LOGIC_VECTOR(2 downto 0);
            Flg_Overflow : out std_logic
        );
    end component;

    -- Signals to connect to the DUT
    signal Clk_tb          : STD_LOGIC := '0';
    signal Reset_tb        : STD_LOGIC := '0';
    signal En_tb           : STD_LOGIC := '0';
    signal PC_Current_tb   : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal PC_Out_tb       : STD_LOGIC_VECTOR(2 downto 0);
    signal Flg_Overflow_tb : STD_LOGIC;

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the DUT (Device Under Test)
    uut: PC
        port map (
            Clk          => Clk_tb,
            reset        => Reset_tb,
            En           => En_tb,
            PC_Current   => PC_Current_tb,
            PC_Out       => PC_Out_tb,
            Flg_Overflow => Flg_Overflow_tb
        );

    -- Clock process
    clk_process : process
    begin
        while true loop
            Clk_tb <= '0';
            wait for clk_period / 2;
            Clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Initial reset
        Reset_tb <= '1';
        wait for clk_period;
        Reset_tb <= '0';
        En_tb <= '1';

        -- Let it count for 8 cycles (to wrap from 000 to 000 and overflow)
        for i in 0 to 5 loop
            PC_Current_tb <= PC_Out_tb;  -- Feed back the current PC
            wait for clk_period;
        end loop;

        -- Disable enable, check PC holds value
        En_tb <= '0';
        wait for clk_period * 2;

        -- Assert reset again
        Reset_tb <= '1';
        wait for clk_period;
        Reset_tb <= '0';

        wait;
    end process;

end Behavioral;
