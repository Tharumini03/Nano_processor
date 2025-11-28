----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/14/2025 02:06:51 PM
-- Design Name: 
-- Module Name: MUX_2W_4B_TB - Behavioral
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

entity MUX_2W_4B_TB is
--  Port ( );
end MUX_2W_4B_TB;

architecture Behavioral of MUX_2W_4B_TB is
COMPONENT Mux_2W_4B
    PORT( Sel : in STD_LOGIC;
          IN_0 : in STD_LOGIC_VECTOR (3 downto 0);
          IN_1 : in STD_LOGIC_VECTOR (3 downto 0);
          Mux_out : out STD_LOGIC_VECTOR (3 downto 0));
END COMPONENT;

SIGNAL IN_0,IN_1,Mux_out : STD_LOGIC_VECTOR (3 downto 0);
SIGNAL Sel : STD_LOGIC;

begin
UUT : Mux_2W_4B
PORT MAP ( Sel => Sel,
           IN_0 => IN_0,
           IN_1 => IN_1,
           Mux_out => Mux_out);

process
begin
    --Sel-'0'
    --230194 : 0011 1000 0011 0011 0010
    --230432 : 0011 1000 0100 0010 0000
    --Sel-'1'
    --230027 : 0011 1000 0010 1000 1011
    --230642 : 0011 1000 0100 1111 0010
    Sel <= '0';
    IN_0 <= "0010";
    IN_1 <= "0000";
    WAIT FOR 100ns;
        
    Sel <= '1';
    IN_0 <= "1000";
    IN_1 <= "1111";
    WAIT FOR 100ns;
          
    Sel <= '0';
    IN_0 <= "0011";
    IN_1 <= "0100";
    WAIT FOR 100ns;
    
    Sel <= '1';
    IN_0 <= "0010";
    IN_1 <= "0100";
    WAIT FOR 100ns;
        
    Sel <= '0';
    IN_0 <= "1000";
    IN_1 <= "1000";
    WAIT FOR 100ns;
        
    Sel <= '1';
    IN_0 <= "0011";
    IN_1 <= "0011";
    WAIT FOR 100ns;
    
    end process;
end Behavioral;
