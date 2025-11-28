library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ROM is
-- No ports for a testbench
end tb_ROM;

architecture Behavioral of tb_ROM is

    -- Component Declaration for the Unit Under Test (UUT)
    component ROM
        Port (
            Memory_Select  : in  STD_LOGIC_VECTOR (2 downto 0);
            Instruction_Bus : out STD_LOGIC_VECTOR (11 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal Memory_Select  : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Instruction_Bus : STD_LOGIC_VECTOR(11 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: ROM
        port map (
            Memory_Select => Memory_Select,
            Instruction_Bus => Instruction_Bus
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Loop through all addresses from 0 to 7
        for i in 0 to 7 loop
            Memory_Select <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;
        end loop;

        wait;  -- Stop simulation
    end process;

end Behavioral;
