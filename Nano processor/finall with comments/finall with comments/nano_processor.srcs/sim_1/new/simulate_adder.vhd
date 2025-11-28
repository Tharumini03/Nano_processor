----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 03:20:28 AM
-- Design Name: 
-- Module Name: simulate_adder - Behavioral
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

entity simulate_adder is
--  Port ( );
end simulate_adder;

architecture Behavioral of simulate_adder is
component CLA_Adder
    Port (A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    C_in : in std_logic;
    S : out std_logic_vector(3 downto 0);
    C_out : out std_logic);
end component;    

signal A : std_logic_vector(3 downto 0);
signal B : std_logic_vector(3 downto 0);
signal C_in : std_logic;
signal S : std_logic_vector(3 downto 0);
signal C_out : std_logic;

begin

uut : CLA_Adder port map(
    A => A,
    B => B,
    C_in => C_in,
    S => S,
    C_out => C_out);
 
 process begin
 
        A <= "1111"; B <= "1111"; C_in <= '0'; wait for 100 ns;
 A <= "1001"; B <= "1111"; C_in <= '0'; wait for 100 ns;
 A <= "1000"; B <= "1011"; C_in <= '0'; wait for 100 ns;
 A <= "0001"; B <= "0001"; C_in <= '1'; wait for 100 ns;
 A <= "0010"; B <= "0011"; C_in <= '1'; wait for 100 ns;
 wait;
 
 
 wait;
 end process;


end Behavioral;
