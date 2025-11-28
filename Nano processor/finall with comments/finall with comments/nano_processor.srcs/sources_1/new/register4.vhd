----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 05:38:19 PM
-- Design Name: 
-- Module Name: register4 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register4 is
    Port ( Clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           En : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end register4;

architecture Behavioral of register4 is

begin
    process (Clk) begin --the code executes during any change in the Clk input
        if (rising_edge(Clk)) then
            if reset = '1' then
                Q <= "0000";
            elsif En = '1' then
                Q <= D;
            end if;
        end if;
    end process;       
                               
end Behavioral;
