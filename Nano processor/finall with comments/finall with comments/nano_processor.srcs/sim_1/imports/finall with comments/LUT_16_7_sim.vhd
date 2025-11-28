----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2025 04:35:55 PM
-- Design Name: 
-- Module Name: LUT_16_7_sim - Behavioral
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

entity LUT_16_7_sim is
--  Port ( );
end LUT_16_7_sim;

architecture Behavioral of LUT_16_7_sim is
COMPONENT  LUT_16_7
    Port ( address : in STD_LOGIC_VECTOR (3 downto 0);
           data : out STD_LOGIC_VECTOR (6 downto 0));
END COMPONENT;

SIGNAL address : std_logic_vector(3 downto 0);
SIGNAL  data : std_logic_vector(6 downto 0);

begin

UUT: LUT_16_7
PORT MAP (address => address,
          data => data);
process
begin
    address <= "0010";
    wait for 200ns;
    
    address <= "0011";
    wait for 200ns;
    
    address <= "0011";
    wait for 200ns;
    
    address <= "1000";
    wait for 200ns;
    
    address <= "0011";
    wait for 200ns;
end process;


end Behavioral;
