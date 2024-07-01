library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity ALU is
    Port (
    ALU_OP: in std_logic_vector(2 downto 0):= (others => '0');
    REG1: in std_logic_vector(15 downto 0):= (others => '0');
    REG2: in std_logic_vector(15 downto 0):= (others => '0');
    RESULT: out std_logic_vector(15 downto 0);
    ZERO: out std_logic := '0'
    );
end ALU;

architecture Behavioral of ALU is

signal result_temp: std_logic_vector(15 downto 0):= (others => '0');

begin

    MUX: process(ALU_OP, REG1, REG2)
    begin
        case ALU_OP is
            when "000" =>
                result_temp <= REG1 + REG2;
            when "001" =>
                result_temp <= REG1-REG2;
            when "010" =>
            --AND
                result_temp <= REG1 AND REG2;
            when "011" =>
            --OR
                result_temp <= REG1 OR REG2;
            when "100" =>
            --SHL 1
                result_temp <= REG1(14 downto 0)&"0";
            when "101" =>
            --SHR 1
                result_temp <= "0"&REG1(15 downto 1);
            when "110" =>
                result_temp <= REG1 XOR REG2;
            when others =>
            --NOT
                result_temp <= NOT(REG1);
        end case;
        
        if(result_temp = x"0000") then
            ZERO <= '1';
        else
            ZERO <= '0';
        end if;
    end process MUX;
    
    RESULT <= result_temp; 
    
end Behavioral;
