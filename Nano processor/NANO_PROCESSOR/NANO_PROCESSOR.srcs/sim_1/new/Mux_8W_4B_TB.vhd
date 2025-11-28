----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 12:40:32 PM
-- Design Name: 
-- Module Name: Mux_8W_4B_TB - Behavioral
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

entity Mux_8W_4B_TB is
--  Port ( );
end Mux_8W_4B_TB;

architecture Behavioral of Mux_8W_4B_TB is
COMPONENT Mux_8W_4B
    PORT ( R0 : in STD_LOGIC_VECTOR (3 downto 0);
           R1 : in STD_LOGIC_VECTOR (3 downto 0);
           R2 : in STD_LOGIC_VECTOR (3 downto 0);
           R3 : in STD_LOGIC_VECTOR (3 downto 0);
           R4 : in STD_LOGIC_VECTOR (3 downto 0);
           R5 : in STD_LOGIC_VECTOR (3 downto 0);
           R6 : in STD_LOGIC_VECTOR (3 downto 0);
           R7 : in STD_LOGIC_VECTOR (3 downto 0);
           S : in STD_LOGIC_VECTOR (2 downto 0);
           Mux_out : out STD_LOGIC_VECTOR (3 downto 0));
END COMPONENT;

SIGNAL R0,R1,R2,R3,R4,R5,R6,R7,Mux_out : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL S: STD_LOGIC_VECTOR (2 downto 0);

begin
UUT: Mux_8W_4B
    PORT MAP( R0 => R0,
              R1 => R1,
              R2 => R2,
              R3 => R3,
              R4 => R4,
              R5 => R5,
              R6 => R6,
              R7 => R7,
              S  => S,
              Mux_out => Mux_out);

process
begin
    --230194 : 0011 1000 0011 0011 0010
    --230432 : 0011 1000 0100 0010 0000
    --230027 : 0011 1000 0010 1000 1011
    --230642 : 0011 1000 0100 1111 0010

    R0 <= "0011";
    R1 <= "1000";
    R2 <= "0010";
    R3 <= "0100";
    R4 <= "0000";
    R5 <= "1011";
    R6 <= "1111";
    R7 <= "1100";
    
    S <= "000";
    WAIT FOR 100ns;
    
    S <= "001";
    WAIT FOR 100ns;
    
    S <= "010";
    WAIT FOR 100ns;
    
    S <= "011";
    WAIT FOR 100ns;

    S <= "100";
    WAIT FOR 100ns;
    
    S <= "101";
    WAIT FOR 100ns;
    
    S <= "110";
    WAIT FOR 100ns;
    
    S <= "111";
    WAIT;
    
end process;    
end Behavioral;
