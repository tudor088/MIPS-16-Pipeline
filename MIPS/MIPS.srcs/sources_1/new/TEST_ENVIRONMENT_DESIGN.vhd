library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity TEST_ENVIRONMENT_DESIGN is
    Port(
        CLOCK: in STD_LOGIC;
        REGISTER0_CONTENT: out STD_LOGIC_VECTOR(15 downto 0);
        REGISTER1_CONTENT: out STD_LOGIC_VECTOR(15 downto 0);
        REGISTER2_CONTENT: out STD_LOGIC_VECTOR(15 downto 0);
        REGISTER3_CONTENT: out STD_LOGIC_VECTOR(15 downto 0);
        REGISTER4_CONTENT: out STD_LOGIC_VECTOR(15 downto 0);
        REGISTER5_CONTENT: out STD_LOGIC_VECTOR(15 downto 0);
        REGISTER6_CONTENT: out STD_LOGIC_VECTOR(15 downto 0);
        REGISTER7_CONTENT: out STD_LOGIC_VECTOR(15 downto 0);
        INSTRUCTION_CURRENT: out STD_LOGIC_VECTOR(15 downto 0);
        PROGRAM_COUNTER: out std_logic_vector (15 downto 0)
    );
end TEST_ENVIRONMENT_DESIGN;

architecture Behavioral of TEST_ENVIRONMENT_DESIGN is

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
end component INSTRUCTION_DECODE;

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
           ALU_Result : out STD_LOGIC_VECTOR (15 downto 0);
           ZERO : out STD_LOGIC := '0';
           WRITE_ADDRESS : out STD_LOGIC_VECTOR (2 downto 0);
           WRITE_ADDRESS_REGISTER1 : in STD_LOGIC_VECTOR (2 downto 0);
           WRITE_ADDRESS_REGISTER2 : in STD_LOGIC_VECTOR (2 downto 0);
           REG_DST : in STD_LOGIC
           );
end component EXECUTE_UNIT;

component MEMORY_UNIT is
    Port ( CLK : in STD_LOGIC;
           ALURes : in STD_LOGIC_VECTOR (15 downto 0);
           ALURes_out : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           MemWrite : in STD_LOGIC := '0';
           MemToReg : in STD_LOGIC := '0';
           DataOut: out STD_LOGIC_VECTOR(15 downto 0):= (others => '0')
           );
end component MEMORY_UNIT;

component MAIN_CONTROL is
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
end component MAIN_CONTROL;

component MPG is
   Port ( btn : in STD_LOGIC;
          clk : in STD_LOGIC;
          en : out STD_LOGIC
   );
end component MPG;

signal button: std_logic;
signal button_pressed: std_logic;

signal INSTRUCTION_sim: std_logic_vector(15 downto 0):= (others => '0');
signal JMP_ADDRESS_sim: std_logic_vector(15 downto 0):= (others => '0');
signal BRANCH_ADDRESS_sim: std_logic_vector(15 downto 0):= (others => '0');
signal NEXT_PC_sim: std_logic_vector(15 downto 0):= (others => '0');
signal DATA_WRITE: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

signal REGISTER1_DATA: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal REGISTER2_DATA: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

signal EXT_IMMEDIATE_sim: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal FUNC_sim: STD_LOGIC_VECTOR(2 downto 0):= (others => '0');

signal ALURes_sim: std_logic_vector(15 downto 0):= (others => '0');
signal ZERO_sim: std_logic :='0';
signal SHIFT_AMMOUNT_sim: STD_LOGIC;

signal READ_DATA_sim: STD_LOGIC_VECTOR(15 downto 0):= (others => '0');
signal ALURES_out_sim: std_logic_vector(15 downto 0):= (others => '0');

signal WRITE_ADDRESS_REGISTER1_sim: std_logic_vector(2 downto 0):= (others => '0');
signal WRITE_ADDRESS_REGISTER2_sim: std_logic_vector(2 downto 0):= (others => '0');
signal WRITE_ADDRESS_sim: std_logic_vector(2 downto 0):= (others => '0');

signal DATA_WRITE_FINAL_sim: std_logic_vector(15 downto 0):= (others => '0');

--CONTROL
signal RegDst_sim: std_logic :='0';
signal ExtOp_sim: std_logic :='0';
signal ALUSrc_sim: std_logic :='0';
signal Branch_sim: std_logic :='0';
signal Jump_sim: std_logic :='0';
signal ALUOp_sim: std_logic_vector(2 downto 0):= (others => '0');
signal MemWrite_sim: std_logic :='0';
signal MemToReg_sim: std_logic :='0';
signal RegWrite_sim: std_logic :='0';
signal PCSrc: std_logic :='0';

signal IF_ID : std_logic_vector(31 downto 0) := (others => '0');
signal ID_EX : std_logic_vector(97 downto 0) := (others => '0');
signal EX_MEM : std_logic_vector(55 downto 0) := (others => '0');
signal MEM_WB : std_logic_vector(36 downto 0) := (others => '0');

begin

PCSrc <= EX_MEM(52) AND EX_MEM(35);
INSTRUCTION_CURRENT <= INSTRUCTION_sim;
PROGRAM_COUNTER <= NEXT_PC_sim - 1;

-- IF/ID Pipeline Register
process(CLOCK)
begin
    if rising_edge(CLOCK) then
        IF_ID(31 downto 16) <= NEXT_PC_sim;
        IF_ID(15 downto 0) <= INSTRUCTION_sim;
    end if;
end process;

-- ID/EX Pipeline Register
process(CLOCK)
begin
    if rising_edge(CLOCK) then
        ID_EX(97 downto 82) <= IF_ID(31 downto 16); --NEXT_PC
        ID_EX(81) <= MemToReg_sim; -- MEM_TO_REG
        ID_EX(80) <= RegWrite_sim; -- REG_WRITE --NXT
        ID_EX(79) <= MemWrite_sim; -- MEM_WRITE
        ID_EX(78) <= Branch_sim; -- BRANCH --NXT
        ID_EX(77 downto 75) <= ALUOp_sim; -- ALU_OP 3B
        ID_EX(74) <= ALUSrc_sim; -- ALU_SRC
        ID_EX(73) <= RegDst_sim; -- REG_DST --NXT
        ID_EX(72 downto 57) <= IF_ID(15 downto 0); -- INSTRUCTION 16B
        ID_EX(56 downto 41) <= REGISTER1_DATA; -- RD1 16B
        ID_EX(40 downto 25) <= REGISTER2_DATA; -- RD2 16B
        ID_EX(24 downto 9) <= EXT_IMMEDIATE_sim; -- EXT_IMMEDIATE 16B
        ID_EX(8 downto 6) <= FUNC_sim; -- FUNC 3B
        ID_EX(5 downto 3) <= WRITE_ADDRESS_REGISTER1_sim; -- DST1 3B --SCHIMBARI
        ID_EX(2 downto 0) <= WRITE_ADDRESS_REGISTER2_sim; -- DST2 3B --SCHIMBARI
    end if;
end process;

-- EX/MEM Pipeline Register
process(CLOCK)
begin
    if rising_edge(CLOCK) then
        EX_MEM(55) <= ID_EX(81); --MEM_TO_REG
        EX_MEM(54) <= ID_EX(80); --REG_WRITE--NXT
        EX_MEM(53) <= ID_EX(79); --MEM_WRITE
        EX_MEM(52) <= ID_EX(78); --BRANCH--NXT
        EX_MEM(51 downto 36) <= Branch_Address_sim; --BRANCH_ADDRESS
        EX_MEM(35) <= ZERO_sim; --ZERO
        EX_MEM(34 downto 19) <= ALURes_sim; --ALU_RES
        EX_MEM(18 downto 3) <= ID_EX(40 downto 25); --RD2_LUAT DINAINTE
        EX_MEM(2 downto 0) <= WRITE_ADDRESS_SIM; --WRITE_ADDRESS--SCHIBARI
    end if;
end process;

-- MEM/WB Pipeline Register
process(CLOCK)
begin
    if rising_edge(CLOCK) then
        MEM_WB(36) <= EX_MEM(55); --MEM_TO_REG
        MEM_WB(35) <= EX_MEM(54); --REG_WRITE
        MEM_WB(34 downto 19) <= DATA_WRITE; --DATA_OUT_READ --SCHIMBARI
        MEM_WB(18 downto 3) <= ALURES_out_sim; --DATA_BYPASS --SCHIMBARI
        MEM_WB(2 downto 0) <= EX_MEM(2 downto 0); --WRITE_ADDRESS --SCHIMBARI
    end if;
end process;

MPG_init: MPG Port map(
    btn => button,
    clk => CLOCK,
    en => button_pressed
);

INSTRUCTION_FETCH_init: INSTRUCTION_FETCH Port map(
    CLK => CLOCK,
    BRANCH_ADDRESS => EX_MEM(51 downto 36),
    JMP_ADDRESS => JMP_ADDRESS_sim,
    JMP_CTRL => Jump_sim,
    BRANCH_CTRL => PCSrc,
    INSTRUCTION => INSTRUCTION_sim,
    NEXT_PC => NEXT_PC_sim
);

INSTRUCTION_DECODE_init: INSTRUCTION_DECODE Port map(
    CLK => CLOCK,
    INSTRUCTION => IF_ID(15 downto 0),
    WRITE_DATA => DATA_WRITE_FINAL_sim, --IESE DIN FINAL
    REGISTER_WRITE => MEM_WB(35),
    REGISTER_DESTINATION => RegDst_sim,
    EXT_OP => ExtOp_sim,
    REG1 => REGISTER1_DATA,
    REG2 => REGISTER2_DATA,
    EXT_IMMEDIATE => EXT_IMMEDIATE_sim,
    JMP_ADDRESS => JMP_ADDRESS_sim,
    FUNC => FUNC_sim,
    SHIFT_AMMOUNT => SHIFT_AMMOUNT_sim,
    reg0_cont => REGISTER0_CONTENT,
    reg1_cont => REGISTER1_CONTENT,
    reg2_cont => REGISTER2_CONTENT,
    reg3_cont => REGISTER3_CONTENT,
    reg4_cont => REGISTER4_CONTENT,
    reg5_cont => REGISTER5_CONTENT,
    reg6_cont => REGISTER6_CONTENT,
    reg7_cont => REGISTER7_CONTENT,
    WRITE_ADDRESS_REGISTER1 => WRITE_ADDRESS_REGISTER1_sim,
    WRITE_ADDRESS_REGISTER2 => WRITE_ADDRESS_REGISTER2_sim,
    WRITE_ADDRESS_IN => MEM_WB(2 downto 0)
);

EXECUTE_UNIT_init: EXECUTE_UNIT Port map(
    PC_PLUS => ID_EX(97 downto 82),
    RD1 => ID_EX(56 downto 41),
    RD2 => ID_EX(40 downto 25),
    EXT_IMMEDIATE => ID_EX(24 downto 9),
    FUNC => ID_EX(8 downto 6),
    ALUSrc => ID_EX(74),
    ALUOp => ID_EX(77 downto 75),
    BranchAddress => Branch_Address_sim,
    ALU_Result => ALURes_sim,
    ZERO => ZERO_sim,
    WRITE_ADDRESS => WRITE_ADDRESS_SIM,
    WRITE_ADDRESS_REGISTER1  => ID_EX(5 downto 3),
    WRITE_ADDRESS_REGISTER2  => ID_EX(2 downto 0),
    REG_DST => ID_EX(73)
);

MEMORY_UNIT_init: MEMORY_UNIT Port map(
    CLK => CLOCK,
    ALURes => EX_MEM(34 downto 19),
    ALURes_out => ALURES_out_sim,
    RD2 => EX_MEM(18 downto 3),
    MemWrite => EX_MEM(53),
    MemToReg => MemToReg_sim,
    DataOut => DATA_WRITE
);

MAIN_CONTROL_init: MAIN_CONTROL Port map(
    INSTRUCTION => IF_ID(15 downto 13),
    RegDst => RegDst_sim,
    ExtOp => ExtOp_sim,
    ALUSrc => ALUSrc_sim,
    Branch => Branch_sim,
    Jump => Jump_sim,
    ALUOp => ALUOp_sim,
    MemWrite => MemWrite_sim,
    MemToReg => MemToReg_sim,
    RegWrite =>RegWrite_sim
);

MemToReg: process(MEM_WB(36), MEM_WB(18 downto 3), MEM_WB(34 downto 19))
begin 
    case MEM_WB(36) is
        when '0' => DATA_WRITE_FINAL_sim <= MEM_WB(18 downto 3);
        when others => DATA_WRITE_FINAL_sim <= MEM_WB(34 downto 19);
    end case;
end process;

end Behavioral;