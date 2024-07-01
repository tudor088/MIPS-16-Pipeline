library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity REGISTER_FILE is
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
end REGISTER_FILE;

architecture Behavioral of REGISTER_FILE is
    type reg_array is array (0 to 7) of std_logic_vector(15 downto 0);
    signal reg_file : reg_array:=(
        x"0000", --reg0
        x"0000", --reg1
        x"0000", --reg2
        x"0001", --reg3
        x"0000", --reg4
        x"0003", --reg5
        x"0000", --reg6
        x"0000"  --reg7
    );
    
    begin
    process(CLK)
        begin
        if rising_edge(CLK) then
            if WRITE_ENABLE = '1' then
                reg_file(conv_integer(WRITE_ADDRESS)) <= WRITE_DATA;
            end if;
        end if;
    end process;
    
    REGISTER1 <= reg_file(conv_integer(READ_ADDRESS1));
    REGISTER2 <= reg_file(conv_integer(READ_ADDRESS2));
    
    reg0_content <= reg_file(0);
    reg1_content <= reg_file(1);
    reg2_content <= reg_file(2);
    reg3_content <= reg_file(3);
    reg4_content <= reg_file(4);
    reg5_content <= reg_file(5);
    reg6_content <= reg_file(6);
    reg7_content <= reg_file(7);
end Behavioral;