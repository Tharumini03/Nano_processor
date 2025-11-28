library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 

entity tb_Reg_bank is --  Port ( ); 
end tb_Reg_bank; 

architecture Behavioral of tb_Reg_bank is -- Component instantiation
 
component Reg_bank  is
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
end component; 

-- Signals 
signal I : std_logic_vector(3 downto 0); 
signal Clk : std_logic := '0';  -- Clock signal 
signal RegSel : std_logic_vector(2 downto 0);-- Memory Selector 
signal resetBank : std_logic; -- Reset signal 
signal  R_0 , R_1 , R_2 , R_3 , R_4 , R_5 , R_6 , R_7  : 
std_logic_vector(3 downto 0);

begin -- Component instantiation 
UUT: Reg_bank port map ( 
I  => I, 
Clk => Clk, 
RegSel => RegSel,  
resetBank => resetBank, 
R0 => R_0, 
R1 => R_1, 
R2 => R_2, 
R3 => R_3, 
R4 => R_4, 
R5 => R_5, 
R6 => R_6, 
R7 => R_7               
);

 -- Clock process 
process begin 
Wait for 20ns; 
Clk<=NOT(Clk); 
end process; -- Stimulus process 

process begin -- Reset activated 

resetBank <= '1'; 
wait for 40 ns; 
resetBank <= '0'; -- Provide input values for each register -- Select different registers 
I <= "1111"; 
RegSel <= "000"; -- Select R0 

wait for 40 ns; 

RegSel <= "001"; -- Select R1 
wait for 40 ns; 

RegSel <= "010"; -- Select R2 
wait for 40 ns; 

RegSel <= "011"; -- Select R3 
wait for 40 ns; 

RegSel <= "100"; -- Select R4 
wait for 40 ns; 

RegSel <= "101"; -- Select R5 
wait for 40 ns; 

RegSel <= "110"; -- Select R6 
wait for 40 ns; 

RegSel <= "111"; -- Select R7 
wait; 

end process; 
end Behavioral; 