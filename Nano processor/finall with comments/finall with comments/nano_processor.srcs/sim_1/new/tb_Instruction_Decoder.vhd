library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Instruction_Decoder is
end TB_Instruction_Decoder;

architecture Behavioral of TB_Instruction_Decoder is

    -- Component declaration
    component Instruction_Decoder is
        Port (
            Rom_Instruction : in  STD_LOGIC_VECTOR (11 downto 0);
            Check_Jump      : in  STD_LOGIC_VECTOR (3 downto 0);
            Reg_Write_EN    : out STD_LOGIC_VECTOR (2 downto 0);
            Reg_Select_A    : out STD_LOGIC_VECTOR (2 downto 0);
            Reg_Select_B    : out STD_LOGIC_VECTOR (2 downto 0);
            ADD_SUB_Select  : out STD_LOGIC;
            Load_Select     : out STD_LOGIC;
            Imme_Value      : out STD_LOGIC_VECTOR (3 downto 0);
            Jump_Flag       : out STD_LOGIC;
            Address_Jump    : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Signals to connect with the UUT
    signal Rom_Instruction : STD_LOGIC_VECTOR (11 downto 0);
    signal Check_Jump      : STD_LOGIC_VECTOR (3 downto 0);
    signal Reg_Write_EN    : STD_LOGIC_VECTOR (2 downto 0);
    signal Reg_Select_A    : STD_LOGIC_VECTOR (2 downto 0);
    signal Reg_Select_B    : STD_LOGIC_VECTOR (2 downto 0);
    signal ADD_SUB_Select  : STD_LOGIC;
    signal Load_Select     : STD_LOGIC;
    signal Imme_Value      : STD_LOGIC_VECTOR (3 downto 0);
    signal Jump_Flag       : STD_LOGIC;
    signal Address_Jump    : STD_LOGIC_VECTOR (2 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Instruction_Decoder
        port map (
            Rom_Instruction => Rom_Instruction,
            Check_Jump      => Check_Jump,
            Reg_Write_EN    => Reg_Write_EN,
            Reg_Select_A    => Reg_Select_A,
            Reg_Select_B    => Reg_Select_B,
            ADD_SUB_Select  => ADD_SUB_Select,
            Load_Select     => Load_Select,
            Imme_Value      => Imme_Value,
            Jump_Flag       => Jump_Flag,
            Address_Jump    => Address_Jump
        );

    -- Stimulus process
    process
    begin 
    
    Check_Jump<="0011"; 
    Rom_Instruction<="";  -- MOV R7 1
    wait for 100ns;
    
    Check_Jump<="0101"; 
    Rom_Instruction<="100100000010";   -- MOV R2  2
    wait for 100ns;
      
    Check_Jump<="0100"; 
    Rom_Instruction<="001110100000";  -- ADD R7 R2
    wait for 100ns; 
    
    Check_Jump<="1001"; 
    Rom_Instruction<="100110000011";  -- MOV R3 3
    wait for 100ns;  
    
    Check_Jump<="0000"; 
    Rom_Instruction<="100010000101";   --MOVE  R1 5
    wait for 100ns; 
    
    Check_Jump<="0001"; 
    Rom_Instruction<="101010000001";  --MOVE R5 1
    wait; 
    
    end process; 
    end Behavioral; 


