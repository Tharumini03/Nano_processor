library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_tb is
end PC_tb;

architecture Behavioral of PC_tb is

    -- Component under test
    component PC is
        Port (
            Clk          : in  STD_LOGIC;
            reset        : in  STD_LOGIC;
            Jump_Flag    : in  STD_LOGIC;
            Jump_Address : in  STD_LOGIC_VECTOR(2 downto 0);
            PC_Out       : out STD_LOGIC_VECTOR(2 downto 0);
            Flg_Overflow : out STD_LOGIC
        );
    end component;

    -- Signals to connect to the PC
    signal Clk_tb          : STD_LOGIC := '0';
    signal reset_tb        : STD_LOGIC := '0';
    signal Jump_Flag_tb    : STD_LOGIC := '0';
    signal Jump_Address_tb : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal PC_Out_tb       : STD_LOGIC_VECTOR(2 downto 0);
    signal Flg_Overflow_tb : STD_LOGIC;

begin

    -- Instantiate the PC
    uut: PC
        Port map (
            Clk          => Clk_tb,
            reset        => reset_tb,
            Jump_Flag    => Jump_Flag_tb,
            Jump_Address => Jump_Address_tb,
            PC_Out       => PC_Out_tb,
            Flg_Overflow => Flg_Overflow_tb
        );

    -- Clock process (period = 10 ns)
    Clk_Process: process
    begin
        while now < 200 ns loop
            Clk_tb <= '0';
            wait for 5 ns;
            Clk_tb <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    -- Stimulus process
    Stim_Proc: process
    begin
        -- Reset PC
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';

        -- Let PC increment normally for a few cycles
        wait for 40 ns;

        -- Jump to address "101"
        Jump_Flag_tb <= '1';
        Jump_Address_tb <= "101";
        wait for 10 ns;

        -- Remove jump flag
        Jump_Flag_tb <= '0';
        wait for 40 ns;

        -- Jump to address "011"
        Jump_Flag_tb <= '1';
        Jump_Address_tb <= "011";
        wait for 10 ns;
        Jump_Flag_tb <= '0';

        wait for 40 ns;

        wait;
    end process;

end Behavioral;
