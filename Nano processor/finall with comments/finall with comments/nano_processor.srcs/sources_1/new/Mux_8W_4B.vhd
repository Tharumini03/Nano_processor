----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 11:48:19 AM
-- Design Name: 
-- Module Name: Mux_8W_4B - Behavioral
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

entity Mux_8W_4B is
 Port (    --values in registers (input values to MUX) and MUX will choose one register value to output
           Data_R0 : in STD_LOGIC_VECTOR (3 downto 0);
           Data_R1 : in STD_LOGIC_VECTOR (3 downto 0);
           Data_R2 : in STD_LOGIC_VECTOR (3 downto 0);
           Data_R3 : in STD_LOGIC_VECTOR (3 downto 0);
           Data_R4 : in STD_LOGIC_VECTOR (3 downto 0);
           Data_R5 : in STD_LOGIC_VECTOR (3 downto 0);
           Data_R6 : in STD_LOGIC_VECTOR (3 downto 0);
           Data_R7 : in STD_LOGIC_VECTOR (3 downto 0);
           
           Sel : in STD_LOGIC_VECTOR (2 downto 0); --address of the register to choose
           Mux_out : out STD_LOGIC_VECTOR (3 downto 0)); --value in the chosen register
end Mux_8W_4B;

architecture Behavioral of Mux_8W_4B is

COMPONENT Mux_8_to_1
    PORT ( S : in STD_LOGIC_VECTOR (2 downto 0);
           D : in STD_LOGIC_VECTOR (7 downto 0);
           EN : in STD_LOGIC :='1';
           Y : out STD_LOGIC);
END COMPONENT;

begin

-- Selects Bit0(least significant bit) from the selected input
MUX_8_TO_1_0: Mux_8_to_1
PORT MAP ( D(0) => Data_R0(0),
           D(1) => Data_R1(0),
           D(2) => Data_R2(0),
           D(3) => Data_R3(0),
           D(4) => Data_R4(0),
           D(5) => Data_R5(0),
           D(6) => Data_R6(0),
           D(7) => Data_R7(0),
           S    => Sel,
           Y    => Mux_out(0));

-- Selects Bit1 from the selected input
MUX_8_TO_1_1: Mux_8_to_1
PORT MAP ( D(0) => Data_R0(1),
           D(1) => Data_R1(1),
           D(2) => Data_R2(1),
           D(3) => Data_R3(1),
           D(4) => Data_R4(1),
           D(5) => Data_R5(1),
           D(6) => Data_R6(1),
           D(7) => Data_R7(1),
           S    => Sel,
           Y    => Mux_out(1)); 

-- Selects Bit2 from the selected input
MUX_8_TO_1_2: Mux_8_to_1
PORT MAP ( D(0) => Data_R0(2),
           D(1) => Data_R1(2),
           D(2) => Data_R2(2),
           D(3) => Data_R3(2),
           D(4) => Data_R4(2),
           D(5) => Data_R5(2),
           D(6) => Data_R6(2),
           D(7) => Data_R7(2),
           S    => Sel,
           Y    => Mux_out(2));        

-- Selects Bit3(most significant bit) from the selected input           
MUX_8_TO_1_3: Mux_8_to_1
    PORT MAP ( D(0) => Data_R0(3),
               D(1) => Data_R1(3),
               D(2) => Data_R2(3),
               D(3) => Data_R3(3),
               D(4) => Data_R4(3),
               D(5) => Data_R5(3),
               D(6) => Data_R6(3),
               D(7) => Data_R7(3),
               S    => Sel,
               Y    => Mux_out(3));        


end Behavioral;
