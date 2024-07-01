library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity INSTRUCTION_DECODE_sim is
--  Port ( );
end INSTRUCTION_DECODE_sim;

architecture Behavioral of INSTRUCTION_DECODE_sim is

component INSTRUCTION_DECODE is
    Port ( CLK : in STD_LOGIC;
           INSTRUCTION : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           WRITE_DATA : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           REGISTER_WRITE : in STD_LOGIC := '0';
           REGISTER_DESTINATION : in STD_LOGIC := '0';
           EXT_OP : in STD_LOGIC := '0';
           REG1 : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           REG2 : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           EXT_IMMEDIATE : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           FUNC : out STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
           SHIFT_AMMOUNT : out STD_LOGIC := '0'
    );
end component INSTRUCTION_DECODE;

signal CLK_sim : STD_LOGIC;
signal INSTRUCTION_sim :  STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal WRITE_DATA_sim : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal REGISTER_WRITE_sim : STD_LOGIC := '0';
signal REGISTER_DESTINATION_sim : STD_LOGIC := '0';
signal EXT_OP_sim : STD_LOGIC := '0';
signal REG1_sim : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal REG2_sim : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal EXT_IMMEDIATE_sim : STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal FUNC_sim : STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
signal SHIFT_AMMOUNT_sim : STD_LOGIC := '0';

begin

InstructionDecode_init: INSTRUCTION_DECODE Port map(
    CLK => CLK_sim,
    INSTRUCTION => INSTRUCTION_sim,
    WRITE_DATA => WRITE_DATA_sim,
    REGISTER_WRITE => REGISTER_WRITE_sim,
    REGISTER_DESTINATION => REGISTER_DESTINATION_sim,
    EXT_OP => EXT_OP_sim,
    REG1 => REG1_sim,
    REG2 => REG2_sim,
    EXT_IMMEDIATE => EXT_IMMEDIATE_sim,
    FUNC => FUNC_sim,
    SHIFT_AMMOUNT => SHIFT_AMMOUNT_sim
);

simulateClk: process
    begin
        loop
            clk_sim <= '0';
            wait for 1ns;
            clk_sim <= '1';
            wait for 1ns;
        end loop;
    end process;
    
    EXT_OP_sim <= '0';
    INSTRUCTION_sim <="0000000001111111";

end Behavioral;
