library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_NanoProcessor is
end tb_NanoProcessor;

architecture Behavioral of tb_NanoProcessor is

    -- Component under test
    component NanoProcessor
        Port (
            Clk : in STD_LOGIC;
            Res : in STD_LOGIC;
            Overflow_led : out STD_LOGIC;
            Zero_led : out STD_LOGIC;
            Reg_7 : out std_logic_vector(3 downto 0);
          --  pc_out_check : out std_logic_vector(2 downto 0);
            --Instruction_Bus_check : out STD_LOGIC_VECTOR (11 downto 0);
            ---Reg_Write_EN_check    : out STD_LOGIC_VECTOR (2 downto 0);
            --Reg_Select_A_check    : out STD_LOGIC_VECTOR (2 downto 0);
            --Reg_Select_B_check    : out STD_LOGIC_VECTOR (2 downto 0);
            --ADD_SUB_Select_check  : out STD_LOGIC;
            --Load_Select_check     : out STD_LOGIC;
            --Imme_Value_check      : out STD_LOGIC_VECTOR (3 downto 0);
           -- Jump_Flag_check       : out STD_LOGIC;
           -- Address_Jump_check    : out STD_LOGIC_VECTOR (2 downto 0);
           -- S_check               : out std_logic_vector(3 downto 0);
              --      val_r3:out STD_LOGIC_VECTOR (3 downto 0);
           -- val_r2: out STD_LOGIC_VECTOR (3 downto 0);
           -- val_b :out STD_LOGIC_VECTOR (3 downto 0);
           -- val_a:out STD_LOGIC_VECTOR (3 downto 0);
            Seven_seg_out : out STD_LOGIC_VECTOR (6 downto 0);
            Anode : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Testbench signals
    signal Clk_tb            : std_logic := '0';
    signal Res_tb            : std_logic := '0';
    signal Overflow_led_tb   : std_logic;
    signal Zero_led_tb       : std_logic;
    signal Reg_7_tb          : std_logic_vector(3 downto 0);
  --  signal pc_out_check   : std_logic_vector(2 downto 0);
 --   signal Instruction_Bus_tb: std_logic_vector(11 downto 0);
--    signal Reg_Write_EN_tb   : std_logic_vector(2 downto 0);
 --   signal Reg_Select_A_tb   : std_logic_vector(2 downto 0);
 --   signal Reg_Select_B_tb   : std_logic_vector(2 downto 0);
  --  signal ADD_SUB_Select_tb : std_logic;
 --   signal Load_Select_tb    : std_logic;
 --   signal Imme_Value_tb     : std_logic_vector(3 downto 0);
 --   signal Jump_Flag_tb      : std_logic;
 --   signal Address_Jump_tb   : std_logic_vector(2 downto 0);
  --  signal S_tb              : std_logic_vector(3 downto 0);
 --   signal    val_r3:STD_LOGIC_VECTOR (3 downto 0);
 --   signal val_r2:  STD_LOGIC_VECTOR (3 downto 0);
 --   signal val_b : STD_LOGIC_VECTOR (3 downto 0);
   -- signal val_a: STD_LOGIC_VECTOR (3 downto 0);
    signal Seven_seg_out : STD_LOGIC_VECTOR (6 downto 0);
    signal Anode : STD_LOGIC_VECTOR (3 downto 0);
    
begin

    -- Instantiate the DUT
    UUT: NanoProcessor
        port map (
            Clk => Clk_tb,
            Res => Res_tb,
            Overflow_led => Overflow_led_tb,
            Zero_led => Zero_led_tb,
            Reg_7 => Reg_7_tb,
            Seven_seg_out => Seven_seg_out,
            Anode => Anode
          --  pc_out_check => pc_out_check,
        --    Instruction_Bus_check => Instruction_Bus_tb,
        --    Reg_Write_EN_check => Reg_Write_EN_tb,
        --    Reg_Select_A_check => Reg_Select_A_tb,
       --     Reg_Select_B_check => Reg_Select_B_tb,
      --      ADD_SUB_Select_check => ADD_SUB_Select_tb,
      --      Load_Select_check => Load_Select_tb,
      --      Imme_Value_check => Imme_Value_tb,
      --      Jump_Flag_check => Jump_Flag_tb,
      --      Address_Jump_check => Address_Jump_tb,
     --       S_check => S_tb,
       --     val_r3 => val_r3,
        --      val_r2 => val_r2,
         --       val_a => val_a,
          --        val_b => val_b,
            
            
        );

    -- Clock generation: 10ns period (100 MHz)
    process
    begin
        while true loop
            Clk_tb <= '0';
            wait for 5 ns;
            Clk_tb <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulus process
    process
    begin
        -- Initial reset
        Res_tb <= '1';
        wait for 20 ns;
        Res_tb <= '0';

        -- Run processor for 200 ns
        wait for 200 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;
