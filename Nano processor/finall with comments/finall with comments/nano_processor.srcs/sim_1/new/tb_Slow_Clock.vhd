LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Slow_Clk_tb IS
END Slow_Clk_tb;

ARCHITECTURE behavior OF Slow_Clk_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Slow_Clk
    PORT(
         Clk_in : IN std_logic;
         Clk_out : OUT std_logic
        );
    END COMPONENT;

   -- Testbench Signals
   signal Clk_in : std_logic := '0';
   signal Clk_out : std_logic;

   -- Clock period definition
   constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Slow_Clk PORT MAP (
          Clk_in => Clk_in,
          Clk_out => Clk_out
        );

    -- Clock process definitions
    clk_process :process
    begin
        while now < 500 ns loop  -- Simulate for 500ns
            Clk_in <= '0';
            wait for clk_period/2;
            Clk_in <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

END;
