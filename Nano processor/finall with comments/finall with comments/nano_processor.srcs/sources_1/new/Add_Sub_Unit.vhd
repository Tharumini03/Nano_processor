----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 12:14:58 AM
-- Design Name: 
-- Module Name: Add_Sub_Unit - Behavioral
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
entity Add_Sub_Unit is
    Port (
    --clk :in std_logic;
    A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        Add_or_Sub : in std_logic;  --add if 0 subtract if 1
        S : out std_logic_vector(3 downto 0);
        Flg_Overflow : out std_logic);
        --Flg_Zero : out std_logic);
end Add_Sub_Unit;

architecture Behavioral of Add_Sub_Unit is

component CLA_Adder
    Port (A : in std_logic_vector(3 downto 0);
        B : in std_logic_vector(3 downto 0);
        C_in : in std_logic;
        S : out std_logic_vector(3 downto 0);
        C_out : out std_logic);
end component;

signal B_eff : std_logic_vector(3 downto 0);
signal Output : std_logic_vector(3 downto 0):= "0000";
signal count : std_logic := '0';

begin

CLA_Adder_0 : CLA_Adder
port map(
        A => A ,
        B => B_eff,
        C_in => Add_or_Sub ,
        S => Output,
        C_out => Flg_Overflow );
        
--calculate B_effective
B_eff(0)<= B(0) XOR Add_or_Sub;
B_eff(1)<= B(1) XOR Add_or_Sub;
B_eff(2)<= B(2) XOR Add_or_Sub;
B_eff(3)<= B(3) XOR Add_or_Sub;


      S <= Output;
      --Flg_Zero <= not( Output(0) or Output(1) or Output(2) or Output(3)); 
      count <= '1';



end Behavioral;