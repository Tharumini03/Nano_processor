----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 12:14:58 AM
-- Design Name: 
-- Module Name: 3Bit_Adder_PC- Behavioral
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

entity Bit3_Adder_PC is
    Port (A : in std_logic_vector(2 downto 0);
          S : out std_logic_vector(2 downto 0);
          Flg_Overflow : out std_logic);
end Bit3_Adder_PC;

architecture Behavioral of Bit3_Adder_PC is

component FA
    Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       C_in : in STD_LOGIC;
       S : out STD_LOGIC;
       C_out : out STD_LOGIC);
end component;

signal p0,p1,p2 : std_logic;
signal g0,g1,g2: std_logic;
signal s0,s1,s2 : std_logic;
signal c0,c1,c2 : std_logic;
signal increment : std_logic_vector(2 downto 0) := "001";
signal final_carry : std_logic; 

begin

FA_0 : FA
port map(
    A => A(0),
    B => increment(0),
    C_in => c0,
    S => s0,
    C_out => c1);

FA_1 : FA
port map(
    A => A(1),
    B =>  increment(1),
    C_in => c1,
    S => s1);

FA_2 : FA
port map(
    A => A(2),
    B =>  increment(2),
    C_in => c2,
    S => s2,
    C_out => final_carry);

    
--carry propagate
p0 <= A(0) xor increment(0);
p1 <= A(1) xor increment(1);
p2 <= A(2) xor increment(2);

--carry generate
g0 <= A(0) and increment(0);
g1 <= A(1) and increment(1); 
g2 <= A(2) and increment(2); 

--carry
c0 <= '0';
c1 <= g0 or (p0 and c0);
c2 <= g1 or (p1 and g0) or (p1 and p0 and c0);

--assign outputs
S(0) <= s0;
S(1) <= s1;
S(2) <= s2;

Flg_Overflow <= final_carry;

end Behavioral;