library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity MAIN_CONTROL is
    Port ( INSTRUCTION : in STD_LOGIC_VECTOR (2 downto 0);
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           Branch : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR (2 downto 0);
           MemWrite : out STD_LOGIC;
           MemToReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end MAIN_CONTROL;

architecture Behavioral of MAIN_CONTROL is
begin

process(INSTRUCTION)
begin
    case INSTRUCTION is
        when "000" =>
        --R TYPE INSTRUCTION
            RegDst <= '1';
            ExtOp <= '0';
            ALUSrc <= '0';
            Branch <= '0';
            Jump <= '0';
            ALUOp <= "000";
            MemWrite <= '0';
            MemToReg <= '0';
            RegWrite <= '1'; 
        when "001" =>
        --ADDI
            RegDst <= '0';
            ExtOp <= '0';
            ALUSrc <= '1';
            Branch <= '0';
            Jump <= '0';
            ALUOp <= "001";
            MemWrite <= '0';
            MemToReg <= '0';
            RegWrite <= '1'; 
        when "010" =>
        --SUBI
            RegDst <= '0';
            ExtOp <= '1';
            ALUSrc <= '1';
            Branch <= '0';
            Jump <= '0';
            ALUOp <= "010";
            MemWrite <= '0';
            MemToReg <= '0';
            RegWrite <= '1'; 
        when "011" =>
        --LW
            RegDst <= '0';
            ExtOp <= '0';
            ALUSrc <= '1';
            Branch <= '0';
            Jump <= '0';
            ALUOp <= "001";
            MemWrite <= '0';
            MemToReg <= '1';
            RegWrite <= '1'; 
        when "100" =>
        --SW
            RegDst <= '0';
            ExtOp <= '0';
            ALUSrc <= '1';
            Branch <= '0';
            Jump <= '0';
            ALUOp <= "001";
            MemWrite <= '1';
            MemToReg <= '1';
            RegWrite <= '0'; 
        when "101" =>
        --BEQ
            RegDst <= '0';
            ExtOp <= '0';
            ALUSrc <= '0';
            Branch <= '1';
            Jump <= '0';
            ALUOp <= "010";
            MemWrite <= '0';
            MemToReg <= '0';
            RegWrite <= '0'; 
        when "110" =>
        --BNE
            RegDst <= '0';
            ExtOp <= '0';
            ALUSrc <= '0';
            Branch <= '1';
            Jump <= '0';
            ALUOp <= "010";
            MemWrite <= '0';
            MemToReg <= '0';
            RegWrite <= '0'; 
        when others =>
        --JMP
            RegDst <= '0';
            ExtOp <= '0';
            ALUSrc <= '0';
            Branch <= '0';
            Jump <= '1';
            ALUOp <= "001";
            MemWrite <= '0';
            MemToReg <= '0';
            RegWrite <= '0'; 
    end case;
end process;

end Behavioral;
