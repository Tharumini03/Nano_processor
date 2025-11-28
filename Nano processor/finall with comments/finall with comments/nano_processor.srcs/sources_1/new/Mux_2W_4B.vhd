----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 01:51:08 PM
-- Design Name: 
-- Module Name: Mux_2W_4B - Behavioral
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

entity Mux_2W_4B is
    Port ( Sel : in STD_LOGIC;
           IN_A : in STD_LOGIC_VECTOR (3 downto 0);
           IN_B : in STD_LOGIC_VECTOR (3 downto 0);
           Mux_out : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_2W_4B;

architecture Behavioral of Mux_2W_4B is

begin
    process(Sel, IN_A, IN_B)
    begin
        if Sel = '0' then
            Mux_out <= IN_A;
        else
            Mux_out <= IN_B;
        end if;
    end process;
    
end Behavioral;
