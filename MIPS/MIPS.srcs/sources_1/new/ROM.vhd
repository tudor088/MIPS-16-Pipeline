library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity ROM is
    Port ( INSTRUCTION_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           INSTRUCTION_DATA : out STD_LOGIC_VECTOR (15 downto 0):= (others => '0'));
end ROM;

architecture Behavioral of ROM is

type ROM_ARRAY is array (0 to 15) of std_logic_vector(15 downto 0);
    signal ROM_FILE : ROM_ARRAY:=(
        B"000_100_101_100_0_000", --ADD R4 R5 R4      0
        B"000_100_101_100_0_000",
        x"0000",
        x"0000",
        B"000_011_100_011_0_001", --SUB R3 R4 R3      1
        x"0000",
        x"0000",
        x"0000",
        x"0000",
        x"0000",
        x"0000",
        x"0000",
        x"0000",
        x"0000",
        x"0000",
        x"0000"
    );
    
--    signal ROM_FILE : ROM_ARRAY:=(
--        B"100_000_101_0000000", --ADDI R1 R1 "1"
--        x"0000",
--        x"0000",
--        x"0000",
--        B"011_000_001_0000000",
--        x"0000",
--        x"0000",
--        x"0000",
--        x"0000",
--        x"0000",
--        x"0000",
--        x"0000",
--        x"0000",
--        x"0000",
--        x"0000",
--        x"0000"
--    );

begin
    process(INSTRUCTION_ADDRESS)
    begin
        INSTRUCTION_DATA <= ROM_FILE(conv_integer(INSTRUCTION_ADDRESS));
    end process;

end Behavioral;
