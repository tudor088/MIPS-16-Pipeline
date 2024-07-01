library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity EXECUTE_UNIT_sim is
--  Port ( );
end EXECUTE_UNIT_sim;

architecture Behavioral of EXECUTE_UNIT_sim is

component EXECUTE_UNIT is
    Port ( PC_PLUS : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           RD1 : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           RD2 : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           EXT_IMMEDIATE : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           FUNC : in STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
           --SHIFT_AMMOUNT : in STD_LOGIC;
           ALUSrc : in STD_LOGIC := '0';
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
           BranchAddress : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           ALU_Result : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           ZERO : out STD_LOGIC := '0');
end component EXECUTE_UNIT;

    signal PC_PLUS_sim: STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal RD1_sim: STD_LOGIC_VECTOR(15 DOWNTO 0); 
    signal RD2_sim: STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal EXT_IMMEDIATE_sim: STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal FUNC_sim: STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal ALUSrc_sim: STD_LOGIC;
    signal ALUOp_sim: STD_LOGIC_VECTOR(2 DOWNTO 0);
    signal BranchAddress_sim: STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal ALU_Result_sim: STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
    signal ZERO_sim: STD_LOGIC;
    
begin

EXECUTE_UNIT_init: EXECUTE_UNIT Port map(
    PC_PLUS => PC_PLUS_sim,
    RD1 =>  RD1_sim,
    RD2 => RD2_sim,
    EXT_IMMEDIATE=>EXT_IMMEDIATE_sim,
    FUNC => FUNC_sim,
    ALUSrc => ALUSrc_sim,
    ALUOp => ALUOp_sim,
    BranchAddress =>BranchAddress_sim,
    ALU_Result =>  ALU_Result_sim,
    ZERO => ZERO_sim
);

RD1_sim <= "0000101011110010"; --2802 -xAF2
EXT_IMMEDIATE_sim <= "0000011010011101"; --x69D
RD2_sim <= "0000011010011101"; --1683 -x69D
ALUSrc_sim <= '0';

ALUOp_sim <= "000";
PC_PLUS_sim <= "0000000000001000";

Funct: process
begin
    FUNC_sim <= "000";
    wait for 2ns;
    FUNC_sim <= "001";
    wait for 2ns;
    FUNC_sim <= "010";
    wait for 2ns;
    FUNC_sim <= "011";
    wait for 2ns;
    FUNC_sim <= "100";
    wait for 2ns;
    FUNC_sim <= "101";
    wait for 2ns;
    FUNC_sim <= "110";
    wait for 2ns;
    FUNC_sim <= "111";
    wait for 2ns;
end process;


end Behavioral;
