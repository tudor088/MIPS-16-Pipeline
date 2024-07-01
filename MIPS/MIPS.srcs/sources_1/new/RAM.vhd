library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity RAM is
    port ( 
        CLK : in std_logic;
        WRITE_ENABLE : in std_logic;
        ADDRESS : in std_logic_vector(15 downto 0);
        WRITE_DATA : in std_logic_vector(15 downto 0);
        READ_DATA : out std_logic_vector(15 downto 0)
    );
end RAM;

architecture syn of RAM is
    type ram_type is array (0 to 63) of std_logic_vector (15 downto 0);
    signal RAM_signal: ram_type := (others => (others => '0'));
    
--    begin
--    process (CLK)
--        begin
--        if CLK'event and CLK = '1' then
--             if WRITE_ENABLE = '1' then
--                 RAM_signal(conv_integer(ADDRESS)) <= WRITE_DATA;
--             else
--                 READ_DATA <= RAM_signal(conv_integer(ADDRESS));
--             end if;
--        end if;
--    end process;
    
    begin
    process(WRITE_ENABLE, ADDRESS, WRITE_DATA)
    begin 
        if WRITE_ENABLE = '1' then
           RAM_signal(conv_integer(ADDRESS)) <= WRITE_DATA;
        else
           READ_DATA <= RAM_signal(conv_integer(ADDRESS));
        end if;
    end process;
     
             
end syn;