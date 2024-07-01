library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity INSTRUCTION_DECODE is
    Port ( CLK : in STD_LOGIC;
           INSTRUCTION : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           WRITE_DATA : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           REGISTER_WRITE : in STD_LOGIC := '0';
           REGISTER_DESTINATION : in STD_LOGIC := '0';
           EXT_OP : in STD_LOGIC := '0';
           REG1 : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           REG2 : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           EXT_IMMEDIATE : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           JMP_ADDRESS : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           FUNC : out STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
           SHIFT_AMMOUNT : out STD_LOGIC := '0';
           reg0_cont : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           reg1_cont : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           reg2_cont : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           reg3_cont : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           reg4_cont : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           reg5_cont : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           reg6_cont : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           reg7_cont : out STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
           WRITE_ADDRESS_REGISTER1: out STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
           WRITE_ADDRESS_REGISTER2: out STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
           WRITE_ADDRESS_IN: in STD_LOGIC_VECTOR(2 downto 0) := (others => '0')
    );
end INSTRUCTION_DECODE;

architecture Behavioral of INSTRUCTION_DECODE is

component REGISTER_FILE is
    port (
        CLK : in std_logic;
        READ_ADDRESS1 : in std_logic_vector (2 downto 0);
        READ_ADDRESS2 : in std_logic_vector (2 downto 0);
        WRITE_ADDRESS : in std_logic_vector (2 downto 0);
        WRITE_DATA : in std_logic_vector (15 downto 0);
        WRITE_ENABLE : in std_logic;
        REGISTER1 : out std_logic_vector (15 downto 0);
        REGISTER2 : out std_logic_vector (15 downto 0);
        reg0_content: out std_logic_vector(15 downto 0);
        reg1_content: out std_logic_vector(15 downto 0);
        reg2_content: out std_logic_vector(15 downto 0);
        reg3_content: out std_logic_vector(15 downto 0);
        reg4_content: out std_logic_vector(15 downto 0);
        reg5_content: out std_logic_vector(15 downto 0);
        reg6_content: out std_logic_vector(15 downto 0);
        reg7_content: out std_logic_vector(15 downto 0)
    );
end component REGISTER_FILE;


begin
    Register_init: REGISTER_FILE Port map(
        CLK => CLK,
        READ_ADDRESS1 => INSTRUCTION(12 downto 10),
        READ_ADDRESS2=> INSTRUCTION(9 downto 7),
        WRITE_ADDRESS=> WRITE_ADDRESS_IN,
        WRITE_DATA=> WRITE_DATA,
        WRITE_ENABLE=> REGISTER_WRITE,
        REGISTER1=> REG1,
        REGISTER2=> REG2,
        reg0_content => reg0_cont,
        reg1_content => reg1_cont,
        reg2_content => reg2_cont,
        reg3_content => reg3_cont,
        reg4_content => reg4_cont,
        reg5_content => reg5_cont,
        reg6_content => reg6_cont,
        reg7_content => reg7_cont
    );
    
    WRITE_ADDRESS_REGISTER1 <= INSTRUCTION(9 downto 7);
    WRITE_ADDRESS_REGISTER2 <= INSTRUCTION(6 downto 4);
    
--    Mux: process(REGISTER_DESTINATION, INSTRUCTION)
--    begin
--        case REGISTER_DESTINATION is
--            when '0' => MuxWrite <= INSTRUCTION(9 downto 7);
--            when others => MuxWrite <= INSTRUCTION(6 downto 4);
--        end case;
--    end process;
    
    ExtensionUnit: process(EXT_OP, INSTRUCTION)
    begin
        case EXT_OP is
        --Zero Extension
            when '0' => EXT_IMMEDIATE <= "000000000"&INSTRUCTION(6 downto 0);
        --Sign Extension
            when others => EXT_IMMEDIATE <= INSTRUCTION(6)&INSTRUCTION(6)&INSTRUCTION(6)&INSTRUCTION(6)&INSTRUCTION(6)&INSTRUCTION(6)&INSTRUCTION(6)&INSTRUCTION(6)&INSTRUCTION(6)&INSTRUCTION(6 downto 0);
        end case;
    end process;
    
    JMP_ADDRESS <= "000"&INSTRUCTION(12 downto 0);
    FUNC <= INSTRUCTION(2 downto 0);
    SHIFT_AMMOUNT <= INSTRUCTION(3);

end Behavioral;
