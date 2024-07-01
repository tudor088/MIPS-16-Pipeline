library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity INSTRUCTION_FETCH_sim is
--  Port ( );
end INSTRUCTION_FETCH_sim;

architecture Behavioral of INSTRUCTION_FETCH_sim is

component INSTRUCTION_FETCH is
    Port ( CLK : in STD_LOGIC;
           BRANCH_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           JMP_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           JMP_CTRL : in STD_LOGIC := '0';
           BRANCH_CTRL : in STD_LOGIC := '0';
           INSTRUCTION : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           NEXT_PC : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0')
           );
end component INSTRUCTION_FETCH;

signal clk_sim: std_logic := '0';
signal branch_address_sim: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal jmp_address_sim: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal jmp_ctrl_sim: std_logic := '0';
signal branch_ctrl_sim: std_logic := '0';
signal instruction_sim: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal next_pc_sim: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');

begin
    InstructionFetch_init: INSTRUCTION_FETCH Port map(
    CLK => clk_sim, 
    BRANCH_ADDRESS => branch_address_sim,
    JMP_ADDRESS => jmp_address_sim, 
    JMP_CTRL => jmp_ctrl_sim, 
    BRANCH_CTRL => branch_ctrl_sim,
    INSTRUCTION => instruction_sim,
    NEXT_PC => next_pc_sim
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
    
--    sim: process
--    begin
--        branch_address_sim<=x"0001";
--        branch_ctrl_sim <= '0';
--        wait for 5ns;
--        branch_ctrl_sim <= '1';
--        wait for 2ns;
--        branch_ctrl_sim <= '0';
--    end process;
    
    
    
end Behavioral;
