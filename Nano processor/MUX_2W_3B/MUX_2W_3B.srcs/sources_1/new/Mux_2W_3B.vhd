----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 10:54:59 AM
-- Design Name: 
-- Module Name: Mux_2W_3B - Behavioral
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

entity Mux_2W_3B is
    Port ( Sel : in STD_LOGIC;
           IN_0 : in STD_LOGIC_VECTOR (2 downto 0);
           IN_1 : in STD_LOGIC_VECTOR (2 downto 0);
           Mux_out : out STD_LOGIC_VECTOR (2 downto 0));
end Mux_2W_3B;

architecture Behavioral of Mux_2W_3B is

begin
    process(Sel, IN_0, IN_1)
    begin
        if Sel = '0' then
            Mux_out <= IN_0;
        else
            Mux_out <= IN_1;
        end if;
    end process;

end Behavioral;
