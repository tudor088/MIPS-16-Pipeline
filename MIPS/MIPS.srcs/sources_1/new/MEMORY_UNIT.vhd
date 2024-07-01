library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity MEMORY_UNIT is
    Port ( CLK : in STD_LOGIC;
           ALURes : in STD_LOGIC_VECTOR (15 downto 0);
           ALURes_out : out STD_LOGIC_VECTOR (15 downto 0);
           RD2 : in STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
           MemWrite : in STD_LOGIC := '0';
           MemToReg : in STD_LOGIC := '0';
           DataOut: out STD_LOGIC_VECTOR(15 downto 0):= (others => '0')
           );
end MEMORY_UNIT;

architecture Behavioral of MEMORY_UNIT is

signal MemData : STD_LOGIC_VECTOR(15 downto 0):= (others => '0');

component RAM is
    port ( 
        CLK : in std_logic;
        WRITE_ENABLE : in std_logic;
        ADDRESS : in std_logic_vector(15 downto 0);
        WRITE_DATA : in std_logic_vector(15 downto 0);
        READ_DATA : out std_logic_vector(15 downto 0)
    );
end component RAM;

begin

RAM_int: RAM Port map(
    CLK=>CLK,
    WRITE_ENABLE=>MemWrite,
    ADDRESS=>ALURes,
    WRITE_DATA=>RD2,
    READ_DATA=>MemData
);

--MuxMemToReg: process(MemToReg, ALURes, MemData)
--begin
--    case MemToReg is
--        when '0' => DataOut <= ALURes;
--        when others => DataOut <= MemData;
--    end case;
--end process MuxMemToReg;

DataOut <= MemData;
ALURes_out <= ALURes;

end Behavioral;
