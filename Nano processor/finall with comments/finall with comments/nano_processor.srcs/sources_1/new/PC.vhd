library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Required for unsigned arithmetic

entity PC is
    Port (
        Clk          : in  STD_LOGIC;
        reset        : in  STD_LOGIC;
        Jump_Flag    : in  STD_LOGIC;
        Jump_Address : in  STD_LOGIC_VECTOR(2 downto 0);
        PC_Out       : out STD_LOGIC_VECTOR(2 downto 0);
        Flg_Overflow : out STD_LOGIC
    );
end PC;

architecture Behavioral of PC is
    signal PC_Reg : unsigned(2 downto 0) := (others => '0');
begin
    process(Clk, reset)
    begin
        if reset = '1' then
            PC_Reg <= (others => '0');
        elsif rising_edge(Clk) then
            if Jump_Flag = '1' then
                PC_Reg <= unsigned(Jump_Address);
            else
                PC_Reg <= PC_Reg + 1;
            end if;
        end if;
    end process;

    PC_Out <= std_logic_vector(PC_Reg);

    -- Simple overflow flag (optional, you can expand logic later)
    Flg_Overflow <= '1' when PC_Reg = "111" else '0';
end Behavioral;
