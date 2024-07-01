library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity EXECUTE_UNIT is
    Port ( PC_PLUS : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           RD1 : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           RD2 : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           EXT_IMMEDIATE : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           FUNC : in STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
           --SHIFT_AMMOUNT : in STD_LOGIC;
           ALUSrc : in STD_LOGIC := '0';
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
           BranchAddress : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           ALU_Result : out STD_LOGIC_VECTOR (15 downto 0);
           ZERO : out STD_LOGIC := '0';
           WRITE_ADDRESS : out STD_LOGIC_VECTOR (2 downto 0);
           WRITE_ADDRESS_REGISTER1 : in STD_LOGIC_VECTOR (2 downto 0);
           WRITE_ADDRESS_REGISTER2 : in STD_LOGIC_VECTOR (2 downto 0);
           REG_DST : in STD_LOGIC
           );
end EXECUTE_UNIT;

architecture Behavioral of EXECUTE_UNIT is

component ALU is
    Port (
    ALU_OP: in std_logic_vector(2 downto 0):= (others => '0');
    REG1: in std_logic_vector(15 downto 0):= (others => '0');
    REG2: in std_logic_vector(15 downto 0):= (others => '0');
    RESULT: out std_logic_vector(15 downto 0);
    ZERO: out std_logic := '0'
    );
end component ALU;

signal ALU_CONTROL: std_logic_vector(2 downto 0):= (others => '0');
signal ALU_MUX: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal EXT_IMM_SH: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal MuxWrite: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');

begin
ALU_init: ALU Port map(
    ALU_OP => ALU_CONTROL,
    REG1=>RD1,
    REG2=>ALU_MUX,
    RESULT => ALU_Result,
    ZERO => ZERO
);

    Mux: process(REG_DST,WRITE_ADDRESS_REGISTER1,WRITE_ADDRESS_REGISTER2)
    begin
        case REG_DST is
            when '0' => MuxWrite <= WRITE_ADDRESS_REGISTER1;
            when others => MuxWrite <= WRITE_ADDRESS_REGISTER2;
        end case;
    end process;
    
    WRITE_ADDRESS <= MuxWrite;

ALUMUX: process(ALUSrc,RD2,EXT_IMMEDIATE)
begin
    case ALUSrc is
        when '0' => ALU_MUX <= RD2;
        when others => ALU_MUX <= EXT_IMMEDIATE;
    end case;
end process;

--BranchAddress <= PC_PLUS + EXT_IMMEDIATE(13 downto 0)&"0";
EXT_IMM_SH <= EXT_IMMEDIATE(13 downto 0)&"00";

BranchAddressProcess: process(PC_PLUS, EXT_IMM_SH)
begin
    BranchAddress <= PC_PLUS + EXT_IMM_SH;
end process;

ALUControl: process(FUNC,ALUOp)
begin
    case ALUOp is
        when "000" =>
            case FUNC is
                when "000" => ALU_CONTROL <= "000";
                when "001" => ALU_CONTROL <= "001";
                when "010" => ALU_CONTROL <= "100";
                when "011" => ALU_CONTROL <= "101";
                when "100" => ALU_CONTROL <= "010";
                when "101" => ALU_CONTROL <= "011";
                when "110" => ALU_CONTROL <= "110";
                when others => ALU_CONTROL <= "111";
            end case;
        when "001" => 
            --ADDI
            ALU_CONTROL <= "000";
        when "010" => 
            --SUBI
            ALU_CONTROL <= "001";
        when "011" => 
            --LW
            ALU_CONTROL <= "000";
        when "100" => 
            --SW
            ALU_CONTROL <= "000";
        when "101" => 
            --BEQ
            ALU_CONTROL <= "001";
        when "110" => 
            --BNE
            ALU_CONTROL <= "001";
        when others => 
            --JMP
            ALU_CONTROL <= "000";
    end case;
end process;

end Behavioral;
