library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_Decoder is
    Port (
        Rom_Instruction : in  STD_LOGIC_VECTOR (11 downto 0); -- The full 12-bit instruction
        Check_Jump      : in  STD_LOGIC_VECTOR (3 downto 0);  -- Value of reg_A (used in JZR)

        Reg_Write_EN    : out STD_LOGIC_VECTOR (2 downto 0);  -- Register to enable writing
        Reg_Select_A    : out STD_LOGIC_VECTOR (2 downto 0);  -- ALU input A
        Reg_Select_B    : out STD_LOGIC_VECTOR (2 downto 0);  -- ALU input B
        ADD_SUB_Select  : out STD_LOGIC;                      -- 0=ADD, 1=NEG
        Load_Select     : out STD_LOGIC;                      -- 1=Use immediate value
        Imme_Value      : out STD_LOGIC_VECTOR (3 downto 0);  -- Immediate value
        Jump_Flag       : out STD_LOGIC;                      -- 1=jump triggered
        Address_Jump    : out STD_LOGIC_VECTOR (2 downto 0)   -- Jump address
        
    );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is 
component Decoder_2_to_4 is 
    Port ( I : in STD_LOGIC_VECTOR (1 downto 0); 
        EN : in STD_LOGIC; 
        Y : out STD_LOGIC_VECTOR (3 downto 0)); 
end component; 

signal ADD, NEG, MOVI, JZR :STD_LOGIC; 
 
begin 

Decoder_2_to_4_0 : Decoder_2_to_4 

Port map (  I(0) => Rom_Instruction(10), 
            I(1) => Rom_Instruction(11),   
            EN   => '1', 
            Y(0) => ADD, 
            Y(1) => NEG, 
            Y(2) => MOVI, 
            Y(3) => JZR );

Reg_Select_A   <= Rom_Instruction(9 downto 7); 
Reg_Select_B   <= Rom_Instruction(6 downto 4); 
Reg_Write_EN    <= Rom_Instruction(9 downto 7);
ADD_SUB_Select <= NEG;
Jump_Flag      <= JZR AND ( NOT(Check_Jump(0) OR Check_Jump(1) OR Check_Jump(2) OR Check_Jump(3))); 
Address_Jump   <= Rom_Instruction(2 downto 0); 
Load_Select    <= MOVI; 
Imme_Value     <= Rom_Instruction(3 downto 0);



end Behavioral;
