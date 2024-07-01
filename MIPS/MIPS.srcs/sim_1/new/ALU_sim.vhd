library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity ALU_sim is
--  Port ( );
end ALU_sim;

architecture Behavioral of ALU_sim is
    
    component ALU is
    Port (
        ALU_OP: in std_logic_vector(2 downto 0);
        REG1: in std_logic_vector(15 downto 0);
        REG2: in std_logic_vector(15 downto 0);
        RESULT: out std_logic_vector(15 downto 0);
        ZERO: out std_logic
    );
    end component ALU;
    
    signal op_sim: std_logic_vector(2 downto 0):= (others => '0');
    signal reg1_sim: std_logic_vector(15 downto 0):= (others => '0');
    signal reg2_sim: std_logic_vector(15 downto 0):= (others => '0');
    signal result_sim: std_logic_vector(15 downto 0):= (others => '0');
    signal zero_sim: std_logic := '0';
    
    begin
    ALU_init: ALU port map(op_sim, reg1_sim, reg2_sim, result_sim, zero_sim);
    
    --reg1_sim <= "0000000000101101";
    reg1_sim <= "0000000000000011";
    reg2_sim <= "0000000000000011";
    
    sim: process
    begin
        op_sim<="000";
        wait for 2ns;      
        op_sim<="001";
        wait for 2ns;      
        op_sim<="010";
        wait for 2ns;       
        op_sim<="011";    
        wait for 2ns;  
        op_sim<="100";    
        wait for 2ns;  
        op_sim<="101";    
        wait for 2ns;  
        op_sim<="110";    
        wait for 2ns;  
        op_sim<="111";    
        wait for 2ns;  
    end process;

end Behavioral;
