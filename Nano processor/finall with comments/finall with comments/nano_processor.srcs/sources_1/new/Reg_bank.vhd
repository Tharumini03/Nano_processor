----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/11/2025 09:56:28 PM
-- Design Name: 
-- Module Name: Reg_bank - Behavioral
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

entity Reg_bank is
    Port ( resetBank : in STD_LOGIC;
           Clk : in STD_LOGIC;
           RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           I : in STD_LOGIC_VECTOR (3 downto 0);
           R0 : out STD_LOGIC_VECTOR (3 downto 0);
           R1 : out STD_LOGIC_VECTOR (3 downto 0);
           R2 : out STD_LOGIC_VECTOR (3 downto 0);
           R3 : out STD_LOGIC_VECTOR (3 downto 0);
           R4 : out STD_LOGIC_VECTOR (3 downto 0);
           R5 : out STD_LOGIC_VECTOR (3 downto 0);
           R6 : out STD_LOGIC_VECTOR (3 downto 0);
           R7 : out STD_LOGIC_VECTOR (3 downto 0));
end Reg_bank;

architecture Behavioral of Reg_bank is

component Decoder_3_to_8
    Port ( En : in STD_LOGIC;
       I : in STD_LOGIC_VECTOR (2 downto 0);
       Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component register4
    Port ( Clk : in STD_LOGIC;
       reset : in STD_LOGIC;
       En : in STD_LOGIC;
       D : in STD_LOGIC_VECTOR (3 downto 0);
       Q : out STD_LOGIC_VECTOR (3 downto 0));
       
end component;

signal R0default : std_logic_vector(3 downto 0) := "0000";
signal reset :std_logic;
signal decoder_En : std_logic := '1';
signal selection : std_logic_vector(7 downto 0);

begin

Decoder_3_to_4_0 : Decoder_3_to_8
    port map(
        En => decoder_En,
        I => RegSel,
        Y => selection);


Reg1 : register4 port map(Clk => Clk, reset => resetBank, En=> selection(1),D=>I, Q=>R1);
Reg2 : register4 port map(Clk => Clk, reset => resetBank, En=> selection(2),D=>I, Q=>R2);
Reg3 : register4 port map(Clk => Clk, reset => resetBank, En=> selection(3),D=>I, Q=>R3);
Reg4 : register4 port map(Clk => Clk, reset => resetBank, En=> selection(4),D=>I, Q=>R4);
Reg5 : register4 port map(Clk => Clk, reset => resetBank, En=> selection(5),D=>I, Q=>R5);
Reg6 : register4 port map(Clk => Clk, reset => resetBank, En=> selection(6),D=>I, Q=>R6);
Reg7 : register4 port map(Clk => Clk, reset => resetBank, En=> selection(7),D=>I, Q=>R7);

--hardcode R0 to 0
R0 <= "0000";



end Behavioral;
