----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 12:14:58 AM
-- Design Name: 
-- Module Name: CLA_Adder - Behavioral
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

entity CLA_Adder is
    Port (A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        C_in : in std_logic;
        S : out std_logic_vector(3 downto 0);
        C_out : out std_logic);
end CLA_Adder;

architecture Behavioral of CLA_Adder is

component FA
    Port ( A : in STD_LOGIC;
       B : in STD_LOGIC;
       C_in : in STD_LOGIC;
       S : out STD_LOGIC;
       C_out : out STD_LOGIC);
end component;

signal p0,p1,p2,p3 : std_logic;
signal g0,g1,g2,g3 : std_logic;
signal s0,s1,s2,s3 : std_logic;
signal c0,c1,c2,c3 : std_logic;
signal final_carry:std_logic;

begin

FA_0 : FA
port map(
    A => A(0),
    B => B(0),
    C_in => c0,
    S => s0,
    C_out => c1);

FA_1 : FA
port map(
    A => A(1),
    B => B(1),
    C_in => c1,
    S => s1);

FA_2 : FA
port map(
    A => A(2),
    B => B(2),
    C_in => c2,
    S => s2);

FA_3 : FA
port map(
    A => A(3),
    B => B(3),
    C_in => c3,
    S => s3,
    C_out => final_carry);
    
--carry propagate
p0 <= A(0) xor B(0);
p1 <= A(1) xor B(1);
p2 <= A(2) xor B(2);
p3 <= A(3) xor B(3);

--carry generate
g0 <= A(0) and B(0);
g1 <= A(1) and B(1); 
g2 <= A(2) and B(2); 
g3 <= A(3) and B(3); 

--carry
c0 <= C_in;
--c1 <= g0 or (p0 and c0);
c2 <= g1 or (p1 and g0) or (p1 and p0 and c0);
c3 <= g2 or (p2 and g1) or (p2 and p1 and g0) or (p2 and p1 and p0 and c0);

--assign outputs
s(0) <= s0;
s(1) <= s1;
s(2) <= s2;
s(3) <= s3;
C_out <= final_carry;

end Behavioral;