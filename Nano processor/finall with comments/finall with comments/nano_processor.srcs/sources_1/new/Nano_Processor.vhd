
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NanoProcessor is
Port (  Clk : in STD_LOGIC;
        Res : in STD_LOGIC;
        Overflow_led : out STD_LOGIC;
        Zero_led : out STD_LOGIC;
        Reg_7 : out std_logic_vector(3 downto 0)
        );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

-- now we have to add the necessary components to the nano processor
--adding slow clock
component Slow_Clk
    Port ( Clk_in : in STD_LOGIC;
       Clk_out : out STD_LOGIC);
end component;

signal Clk_out_I : std_logic;

-- adding the program counter
component PC
    Port (
    Clk    : in  STD_LOGIC;
    reset  : in  STD_LOGIC;
    En     : in  STD_LOGIC;
    PC_Current : in STD_LOGIC_VECTOR(2 downto 0);
    Jump_Flag : in  STD_LOGIC;
    Jump_Address : in STD_LOGIC_VECTOR(2 downto 0);
    PC_Out : out STD_LOGIC_VECTOR(2 downto 0);
    Flg_Overflow : out std_logic);
end component;

-- adding the rom
component ROM
Port ( Memory_Select : in STD_LOGIC_VECTOR (2 downto 0); 
       Instruction_Bus : out STD_LOGIC_VECTOR (11 downto 0));
end component;

signal data_I : STD_logic_vector(11 downto 0); -- instruction to be executed in binary pattern

-- adding the instruction decoder
component Instruction_Decoder
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
end component;

signal Reg_Write_EN_I : STD_logic_vector(2 downto 0); -- mapped to the 3-8 decorder of the register bank
signal Load_Select_I : STD_logic; -- mapped to the Sel pin of the 2-4 MUX
signal Imme_Value_I : STD_logic_vector(3 downto 0); -- mapped to the input B of MUX_2_4

signal Reg_Select_A_I : STD_logic_vector(2 downto 0); -- intermdeiate signals for selecting the registers from the MUX_8_4
signal Reg_Select_B_I : STD_logic_vector(2 downto 0);

signal ADD_SUB_Select_I : STD_logic; -- this signal will be the add sub selction signal of Add Sub unit

--signal Chek_Jump_I : STD_logic_vector(3 downto 0); -- used when a jump instruction is exectued
signal Jump_Flag_I : STD_logic; -- this activates when jump instructon occurs
signal Address_Jump_I : STD_logic_vector(2 downto 0); -- this will send the address to jump

-- adding the add sub unit component
component Add_Sub_Unit
    Port (A : in std_logic_vector(3 downto 0);
    B : in std_logic_vector(3 downto 0);
    Add_or_Sub : in std_logic;  --add if 0 subtract if 1
    S : out std_logic_vector(3 downto 0);
    Flg_Overflow : out std_logic;
    Flg_Zero : out std_logic);
end component;

component Mux_2W_4B --to select whether to write the output of ALU or to write immediate value
 Port ( Sel : in STD_LOGIC;
          IN_A : in STD_LOGIC_VECTOR (3 downto 0);
          IN_B : in STD_LOGIC_VECTOR (3 downto 0);
          Mux_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

--adding the register bank  
component Reg_bank  
    Port ( resetBank : in STD_LOGIC;
       Clk : in STD_LOGIC;
       RegSel : in STD_LOGIC_VECTOR (2 downto 0); --select the register to write the value
       I : in STD_LOGIC_VECTOR (3 downto 0); --value to enter into register
       R0 : out STD_LOGIC_VECTOR (3 downto 0);
       R1 : out STD_LOGIC_VECTOR (3 downto 0);
       R2 : out STD_LOGIC_VECTOR (3 downto 0);
       R3 : out STD_LOGIC_VECTOR (3 downto 0);
       R4 : out STD_LOGIC_VECTOR (3 downto 0);
       R5 : out STD_LOGIC_VECTOR (3 downto 0);
       R6 : out STD_LOGIC_VECTOR (3 downto 0);
       R7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Reg_bank_write_val : STD_logic_vector(3 downto 0); -- --ouput value to store in the register(chosen by 2way 4bit MUX)

-- followng intermediate signals that represents the values in each of 8 registers
-- they will be mapped to the 8_4_mux (to both)
signal R0_I : STD_LOGIC_VECTOR(3 downto 0);
signal R1_I : STD_LOGIC_VECTOR(3 downto 0);
signal R2_I : STD_LOGIC_VECTOR(3 downto 0);
signal R3_I : STD_LOGIC_VECTOR(3 downto 0);
signal R4_I : STD_LOGIC_VECTOR(3 downto 0);
signal R5_I : STD_LOGIC_VECTOR(3 downto 0);
signal R6_I : STD_LOGIC_VECTOR(3 downto 0);
signal R7_I : STD_LOGIC_VECTOR(3 downto 0);


-- adding the necessary multiplexers
component Mux_8W_4B
  Port (  --values in registers (input values to MUX) and MUX will choose one register value to output
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
end component;

-- these will be the inputs to the add sub unit 
signal A_I : STD_LOGIC_VECTOR(3 downto 0); -- value of register A (first input to Add/Sub unit
signal B_I : STD_LOGIC_VECTOR(3 downto 0); -- value of register B (second input to Add/Sub unit
signal S_Out_I : STD_LOGIC_VECTOR(3 downto 0); -- output from the add sub unit (this will be mapped to MUX_2_4 pin A)

component Mux_2W_3B
    Port ( Sel : in STD_LOGIC;
           IN_A: in STD_LOGIC_VECTOR (2 downto 0);
           IN_B : in STD_LOGIC_VECTOR (2 downto 0);
           Mux_out : out STD_LOGIC_VECTOR (2 downto 0));
end component;



signal pc_out_I : STD_logic_vector(2 downto 0);-- intermediate value of the output of the program counter 
signal pc_in_I : STD_logic_vector(2 downto 0):= "000"; -- intermediate value of the inpur signal  to the program counter


begin

--instance for slow clock
Slow_Clk_0 : Slow_Clk
    port map( Clk_in => Clk,
              Clk_out => Clk_out_I);   

-- instance for program counter
PC_0 : PC
    port map(
        Clk => Clk_out_I,
        En => '1',
        Jump_Flag => Jump_Flag_I,
        Jump_Address => Address_Jump_I,
        reset => Res,
        PC_Current => pc_in_I,  -- take the previous PC output value as the input to the next cycle
        PC_Out => pc_out_I -- modify the output address
        );

-- instance for Program ROM
ROM_0 : ROM
    port map(
        Memory_Select => pc_out_I,
        Instruction_Bus => data_I
        );
        
--instance for instruction decoder
Instruction_Decoder_0 : Instruction_Decoder
    port map(
      Rom_Instruction => data_I, 
      Reg_Write_EN => Reg_Write_EN_I, 
      Load_Select => Load_Select_I,
      Imme_Value => Imme_Value_I,
      Reg_Select_A=> Reg_Select_A_I,
      ------------------------
      Reg_Select_B => Reg_Select_B_I,
      ADD_SUB_Select => ADD_SUB_Select_I,
      ------------------------------------------
      Check_Jump => A_I,
      Jump_Flag => Jump_Flag_I,
      Address_Jump => Address_Jump_I
      );   
      
--instantiate Add_Sub_Unit     
Add_Sub_Unit_0 : Add_Sub_Unit
          port map(
             A => A_I,
             B => B_I,
             Add_or_Sub => ADD_SUB_Select_I , 
             S => S_Out_I,
             Flg_Overflow =>Overflow_led,
             Flg_Zero => Zero_led 
          );



-- creating an instance for MUX_2_4 --to choose immediate value or the register value
Mux_2W_4B_0 : Mux_2W_4B
    port map(
            IN_A => S_Out_I,
            IN_B => Imme_Value_I,
            Sel => Load_Select_I,
            Mux_out => Reg_bank_write_val --ouput value to store in the register
    );
    
    
--instance for Register bank
Reg_bank_0 : Reg_bank
    port map(
       I => Reg_bank_write_val, --value to write
       Clk => Clk, 
       RegSel => Reg_Write_EN_I,  -- which register to write
       resetBank => Res, -- mapped to the reset button of the whole processor
       -- outputs from all the registers
       R0 => R0_I,
       R1 => R1_I,
       R2 => R2_I,
       R3 => R3_I,
       R4 => R4_I,
       R5 => R5_I,
       R6 => R6_I,
       R7 => R7_I
    );

        
-- we need to create two instances of 8 way 4 bit MUX
Mux_8W_4B_A : Mux_8W_4B --which register out of 8 registers is to be choosed as A
    port map(
        Data_R0 => R0_I, --R0_I is the value received by the registers(which is the value stored in the registers)
        Data_R1 => R1_I,
        Data_R2 => R2_I,
        Data_R3 => R3_I,
        Data_R4 => R4_I,
        Data_R5 => R5_I,
        Data_R6 => R6_I,
        Data_R7 => R7_I,
        
        Sel => Reg_Select_A_I, --register is choosen according  register specified in the  instruction decorder 
        ---------------------
        Mux_Out => A_I --output the value to store in register A
        );
        
 Mux_8W_4B_B : Mux_8W_4B --which register out of 8 registers is to be choosed as B
     port map(
         Data_R0 => R0_I,
         Data_R1 => R1_I,
         Data_R2 => R2_I,
         Data_R3 => R3_I,
         Data_R4 => R4_I,
         Data_R5 => R5_I,
         Data_R6 => R6_I,
         Data_R7 => R7_I,
         
         Sel => Reg_Select_B_I, --register is choosen according  register specified in the  instruction decorder 
         --------------------
         MUX_Out => B_I --output the value to store in register B
    );


end Behavioral;
