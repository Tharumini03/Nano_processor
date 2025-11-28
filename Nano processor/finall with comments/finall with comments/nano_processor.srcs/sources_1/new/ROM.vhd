library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use ieee.numeric_std.all; 


entity ROM is 

Port ( Memory_Select : in STD_LOGIC_VECTOR (2 downto 0); 
       Instruction_Bus : out STD_LOGIC_VECTOR (11 downto 0));
 
end ROM; 

architecture Behavioral of ROM is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0); 

signal P_ROM : rom_type := ( 
"101110000001", -- MOVI R7, 1 
"100100000010", -- MOVI R2, 2 
"001110100000", -- ADD R7, R2 
"100110000011", -- MOVI R3, 3 
"001110110000", -- ADD R7, R3 
"110000000111", -- JZR R0, 7 
"110000000111", -- JZR R0, 7 
"110000000111"  -- JZR R0, 7 
); 

Begin 

Instruction_Bus <= P_ROM(to_integer(unsigned(Memory_Select))); 

end Behavioral; 