----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 07:28:12 PM
-- Design Name: 
-- Module Name: tb_register4 - Behavioral
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

entity tb_register4 is
--  Port ( );
end tb_register4;

architecture Behavioral of tb_register4 is

component register4
    Port ( Clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        En : in STD_LOGIC;
        D : in STD_LOGIC_VECTOR (3 downto 0);
        Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Clk,reset,En : std_logic;
signal D,Q : std_logic_vector(3 downto 0);
 
begin

uut : register4 port map(
    Clk =>Clk,
    reset => reset,
    En => En,
    D => D,
    Q => Q
    );

process begin
    Clk <= '0';--all zero
    En <= '0';
    reset <= '0';
    D <= "0000";
    wait for 100ns;
    
    Clk <= '0'; --giving input 
    En <= '0';
    reset <= '0';
    D <= "0000";
    
         
      
end process;
end Behavioral;
