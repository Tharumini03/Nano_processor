----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 11:10:57 AM
-- Design Name: 
-- Module Name: MUX_2W_3B_TB - Behavioral
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

entity MUX_2W_3B_TB is
--  Port ( );
end MUX_2W_3B_TB;

architecture Behavioral of MUX_2W_3B_TB is
COMPONENT Mux_2W_3B
    PORT( Sel : in STD_LOGIC;
          IN_0 : in STD_LOGIC_VECTOR (2 downto 0);
          IN_1 : in STD_LOGIC_VECTOR (2 downto 0);
          Mux_out : out STD_LOGIC_VECTOR (2 downto 0));
END COMPONENT;

SIGNAL IN_0,IN_1,Mux_out : STD_LOGIC_VECTOR (2 downto 0);
SIGNAL Sel : STD_LOGIC;

begin

UUT : Mux_2W_3B
PORT MAP ( Sel => Sel,
           IN_0 => IN_0,
           IN_1 => IN_1,
           Mux_out => Mux_out);
           
process
begin
    --Sel-'0'
    --230194 : 111 000 001 100 110 010
    --230432 : 111 000 010 000 100 000
    --Sel-'1'
    --230027 : 111 000 001 010 001 011
    --230642 : 111 000 010 011 110 010
    Sel <= '0';
    IN_0 <= "010";
    IN_1 <= "000";
    WAIT FOR 100ns;
    
    Sel <= '1';
    IN_0 <= "011";
    IN_1 <= "010";
    WAIT FOR 100ns;
      
    Sel <= '0';
    IN_0 <= "100";
    IN_1 <= "000";
    WAIT FOR 100ns;

    Sel <= '1';
    IN_0 <= "001";
    IN_1 <= "110";
    WAIT FOR 100ns;
    
    Sel <= '0';
    IN_0 <= "010";
    IN_1 <= "000";
    WAIT FOR 100ns;
    
    Sel <= '1';
    IN_0 <= "010";
    IN_1 <= "011";
    WAIT FOR 100ns;

end process;
end Behavioral;
