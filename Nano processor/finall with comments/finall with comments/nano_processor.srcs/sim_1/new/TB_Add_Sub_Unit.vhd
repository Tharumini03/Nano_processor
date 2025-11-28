----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 09:03:03 PM
-- Design Name: 
-- Module Name: TB_Add_Sub_Unit - Behavioral
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

entity TB_Add_Sub_Unit is
--  Port ( );
end TB_Add_Sub_Unit;

architecture Behavioral of TB_Add_Sub_Unit is
component Add_Sub_Unit
    Port (A : in std_logic_vector(3 downto 0);
          B : in std_logic_vector(3 downto 0);
          Add_or_Sub : in std_logic;  --add if 0 subtract if 1
          S : out std_logic_vector(3 downto 0);
          Flg_Overflow : out std_logic;
          Flg_Zero : out std_logic);
end component;    

signal A : std_logic_vector(3 downto 0);
signal B : std_logic_vector(3 downto 0);
signal Add_or_Sub : std_logic;  --add if 0 subtract if 1
signal S : std_logic_vector(3 downto 0);
signal Flg_Overflow : std_logic;
signal Flg_Zero : std_logic;

begin

uut : Add_Sub_Unit port map(
    A => A,
    B => B,
    Add_or_Sub => Add_or_Sub,
    S => S,
    Flg_Overflow => Flg_Overflow,
    Flg_Zero => Flg_Zero);
 
process begin
 
A <= "0100"; B <= "0100"; Add_or_Sub <= '0'; wait for 100 ns;
A <= "0100"; B <= "0100"; Add_or_Sub <= '1'; wait for 100 ns;
 
A <= "1111"; B <= "1111"; Add_or_Sub <= '0'; wait for 100 ns;
A <= "1111"; B <= "1111"; Add_or_Sub <= '1'; wait;

end process;

end Behavioral;
