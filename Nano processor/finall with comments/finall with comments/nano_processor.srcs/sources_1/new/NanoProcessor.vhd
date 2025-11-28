library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NanoProcessor is
    Port (  
        Clk : in STD_LOGIC;
        Res : in STD_LOGIC;
        Overflow_led : out STD_LOGIC;
        Zero_led : out STD_LOGIC;
        Reg_7 : out std_logic_vector(3 downto 0);
        
      --  pc_out_check : out std_logic_vector(2 downto 0);
    --    Instruction_Bus_check : out STD_LOGIC_VECTOR (11 downto 0);
   --     Reg_Write_EN_check    : out STD_LOGIC_VECTOR (2 downto 0);
  --      Reg_Select_A_check    : out STD_LOGIC_VECTOR (2 downto 0);
  --      Reg_Select_B_check    : out STD_LOGIC_VECTOR (2 downto 0);
 --       ADD_SUB_Select_check  : out STD_LOGIC;
 --       Load_Select_check     : out STD_LOGIC;
 --       Imme_Value_check      : out STD_LOGIC_VECTOR (3 downto 0);
   --     Jump_Flag_check       : out STD_LOGIC;
   --     Address_Jump_check    : out STD_LOGIC_VECTOR (2 downto 0);
    --    S_check : out std_logic_vector(3 downto 0);
    --    val_r3:out STD_LOGIC_VECTOR (3 downto 0);
    --    val_r2: out STD_LOGIC_VECTOR (3 downto 0);
    --    val_b :out STD_LOGIC_VECTOR (3 downto 0);
    --    val_a:out STD_LOGIC_VECTOR (3 downto 0);
        Seven_seg_out : out STD_LOGIC_VECTOR (6 downto 0);
        Anode : out STD_LOGIC_VECTOR (3 downto 0)
        
        
    );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

    -- Component declarations
    component Slow_Clk
        Port ( Clk_in : in STD_LOGIC;
               Clk_out : out STD_LOGIC);
    end component;

    component PC
        Port (
            Clk    : in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            Jump_Flag : in  STD_LOGIC;
            Jump_Address : in STD_LOGIC_VECTOR(2 downto 0);
            PC_Out : out STD_LOGIC_VECTOR(2 downto 0);
            Flg_Overflow : out std_logic
        );
    end component;

    component ROM
        Port ( Memory_Select : in STD_LOGIC_VECTOR (2 downto 0); 
               Instruction_Bus : out STD_LOGIC_VECTOR (11 downto 0));
    end component;

    component Instruction_Decoder
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
            Address_Jump    : out STD_LOGIC_VECTOR (2 downto 0));
      
    end component;

    component Add_Sub_Unit
        Port (
        --Clk : in std_logic;
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            Add_or_Sub : in std_logic;
            S : out std_logic_vector(3 downto 0);
            Flg_Overflow : out std_logic
            --Flg_Zero : out std_logic
        );
    end component;

    component Mux_2W_4B
        Port ( 
            Sel : in STD_LOGIC;
            IN_A : in STD_LOGIC_VECTOR (3 downto 0);
            IN_B : in STD_LOGIC_VECTOR (3 downto 0);
            Mux_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component Reg_bank  
        Port (
            resetBank : in STD_LOGIC;
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
            R7 : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component Mux_8W_4B
        Port (
            Data_R0 : in STD_LOGIC_VECTOR (3 downto 0);
            Data_R1 : in STD_LOGIC_VECTOR (3 downto 0);
            Data_R2 : in STD_LOGIC_VECTOR (3 downto 0);
            Data_R3 : in STD_LOGIC_VECTOR (3 downto 0);
            Data_R4 : in STD_LOGIC_VECTOR (3 downto 0);
            Data_R5 : in STD_LOGIC_VECTOR (3 downto 0);
            Data_R6 : in STD_LOGIC_VECTOR (3 downto 0);
            Data_R7 : in STD_LOGIC_VECTOR (3 downto 0);
            Sel : in STD_LOGIC_VECTOR (2 downto 0);
            Mux_out : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    component LUT_16_7
        Port(
            address : in STD_LOGIC_VECTOR (3 downto 0);
            data : out STD_LOGIC_VECTOR (6 downto 0)
            );
    end component;

    -- Signal declarations
    signal Clk_out_I : std_logic;

    signal pc_out_I, pc_in_I, Address_Jump_I : std_logic_vector(2 downto 0);
    signal data_I : STD_logic_vector(11 downto 0);

    signal Reg_Write_EN_I, Reg_Select_A_I, Reg_Select_B_I : STD_logic_vector(2 downto 0);
    signal Load_Select_I, ADD_SUB_Select_I, Jump_Flag_I : STD_logic;
    signal Imme_Value_I, Reg_bank_write_val : STD_logic_vector(3 downto 0);
    signal A_I, B_I, S_Out_I : STD_LOGIC_VECTOR(3 downto 0);

    signal R0_I, R1_I, R2_I, R3_I, R4_I, R5_I, R6_I, R7_I : STD_LOGIC_VECTOR(3 downto 0);
begin

    -- Slow Clock
    Slow_Clk_0 : Slow_Clk
        port map( Clk_in => Clk, Clk_out => Clk_out_I );   

    -- Program Counter
    PC_0 : PC
        port map(
            Clk => Clk_out_I,
            Jump_Flag => Jump_Flag_I,
            Jump_Address => Address_Jump_I,
            reset => Res,
            PC_Out => pc_out_I
        );

    -- ROM
    ROM_0 : ROM
        port map(
            Memory_Select => pc_out_I,
            Instruction_Bus => data_I
        );

    -- Instruction Decoder
    Instruction_Decoder_0 : Instruction_Decoder
        port map(
            Rom_Instruction => data_I,
            Check_Jump => A_I,
            Reg_Write_EN => Reg_Write_EN_I,
            Reg_Select_A => Reg_Select_A_I,
            Reg_Select_B => Reg_Select_B_I,
            ADD_SUB_Select => ADD_SUB_Select_I,
            Load_Select => Load_Select_I,
            Imme_Value => Imme_Value_I,
            Jump_Flag => Jump_Flag_I,
            Address_Jump => Address_Jump_I
        );

    -- Add/Sub Unit
    Add_Sub_Unit_0 : Add_Sub_Unit
        port map(
        --clk => Clk_out_I,
            A => A_I,
            B => B_I,
            Add_or_Sub => ADD_SUB_Select_I,
            S => S_Out_I,
            Flg_Overflow => Overflow_led
            --Flg_Zero => Zero_led
        );

    -- MUX: ALU result or Immediate
    Mux_2W_4B_0 : Mux_2W_4B
        port map(
            IN_A => S_Out_I,
            IN_B => Imme_Value_I,
            Sel => Load_Select_I,
            Mux_out => Reg_bank_write_val
        );

    -- Register Bank
    Reg_bank_0 : Reg_bank
        port map(
            resetBank => Res,
            Clk => Clk_out_I,
            RegSel => Reg_Write_EN_I,
            I => Reg_bank_write_val,
            R0 => R0_I,
            R1 => R1_I,
            R2 => R2_I,
            R3 => R3_I,
            R4 => R4_I,
            R5 => R5_I,
            R6 => R6_I,
            R7 => R7_I
        );

    -- MUX A
    Mux_8_A : Mux_8W_4B
        port map(
            Data_R0 => R0_I, Data_R1 => R1_I, Data_R2 => R2_I, Data_R3 => R3_I,
            Data_R4 => R4_I, Data_R5 => R5_I, Data_R6 => R6_I, Data_R7 => R7_I,
            Sel => Reg_Select_A_I,
            Mux_out => A_I
        );

    -- MUX B
    Mux_8_B : Mux_8W_4B
        port map(
            Data_R0 => R0_I, Data_R1 => R1_I, Data_R2 => R2_I, Data_R3 => R3_I,
            Data_R4 => R4_I, Data_R5 => R5_I, Data_R6 => R6_I, Data_R7 => R7_I,
            Sel => Reg_Select_B_I,
            Mux_out => B_I
        );
        
     Seven_segment : LUT_16_7
        port map(
             address => R7_I,
             data => Seven_seg_out);

    -- Feedback PC output to input (for next cycle)
    pc_in_I <= pc_out_I;

    -- Output register R7 for external observation
    Reg_7 <= R7_I;
    
    Zero_led <= '1' when R7_I = "0000" else '0';
    Anode <= "1110";

        --pc_out_check <= pc_out_I;
   --          Instruction_Bus_check  <= data_I ;
   --             Reg_Write_EN_check<=Reg_Write_EN_I;
   --             Reg_Select_A_check<=Reg_Select_A_I;
    --            Reg_Select_B_check<=Reg_Select_B_I;
     --           ADD_SUB_Select_check<=ADD_SUB_Select_I;
     --           Load_Select_check<=Load_Select_I;
       --         Imme_Value_check<=Imme_Value_I;
      --          Jump_Flag_check<=Jump_Flag_I;
      --          Address_Jump_check<=Address_Jump_I;
       --         S_check<=S_Out_I;
       --         val_r3<=R3_I;
       --         val_r2<=R2_I;
       --         val_b <=B_I;
      --          val_a <=A_I;
end Behavioral;
