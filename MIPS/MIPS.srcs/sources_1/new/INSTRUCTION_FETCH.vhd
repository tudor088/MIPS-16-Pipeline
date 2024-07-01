library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity INSTRUCTION_FETCH is
    Port ( CLK : in STD_LOGIC;
           BRANCH_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           JMP_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           JMP_CTRL : in STD_LOGIC := '0';
           BRANCH_CTRL : in STD_LOGIC := '0';
           INSTRUCTION : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           NEXT_PC : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0')
           );
end INSTRUCTION_FETCH;

architecture Behavioral of INSTRUCTION_FETCH is

component ROM is
    Port ( INSTRUCTION_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           INSTRUCTION_DATA : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0'));
end component ROM;

signal PC: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal PC_PLUS: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal BRANCH_MUX: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal JMP_MUX: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

begin

ROM_init: ROM Port map(INSTRUCTION_ADDRESS=>PC, INSTRUCTION_DATA=>INSTRUCTION);

ProgramCounter: process(CLK,JMP_MUX)
begin
    if(rising_edge(CLK)) then
        PC<=JMP_MUX;
    end if;
end process;


PC_PLUS <= PC + 1;

BranchMux: process(BRANCH_CTRL,PC_PLUS,BRANCH_ADDRESS)
begin
    if(BRANCH_CTRL ='0') then
        BRANCH_MUX <= PC_PLUS;
    else
        BRANCH_MUX <= BRANCH_ADDRESS;
    end if;
end process;

JumpMux: process(JMP_CTRL, BRANCH_MUX, JMP_ADDRESS)
begin
    if(JMP_CTRL ='0') then
        JMP_MUX<=BRANCH_MUX;
    else
        JMP_MUX <= JMP_ADDRESS;
    end if;
end process;

NEXT_PC <= PC_PLUS;

end Behavioral;
