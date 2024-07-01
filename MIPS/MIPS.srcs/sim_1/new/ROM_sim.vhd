library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity ROM_sim is
--  Port ( );
end ROM_sim;

architecture Behavioral of ROM_sim is

component ROM is
    Port ( INSTRUCTION_ADDRESS : in STD_LOGIC_VECTOR (15 downto 0);
           INSTRUCTION_DATA : out STD_LOGIC_VECTOR (15 downto 0)
    );
end component ROM;

signal address_sim: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');
signal data_sim: STD_LOGIC_VECTOR (15 downto 0):= (others => '0');

begin

    ROM_init: ROM Port map(address_sim, data_sim);
    
    Sim: process
    begin
        address_sim <= x"0000";
        wait for 2ns;
        address_sim <= x"0001";
        wait for 2ns;
        address_sim <= x"0002";
        wait for 2ns;
        address_sim <= x"0003";
        wait for 2ns;
        address_sim <= x"0004";
        wait for 2ns;
        address_sim <= x"0005";
        wait for 2ns;
        address_sim <= x"0006";
        wait for 2ns;
        address_sim <= x"0007";
        wait for 2ns;
        address_sim <= x"0008";
        wait for 2ns;
        address_sim <= x"0009";
        wait for 2ns;
        address_sim <= x"000A";
        wait for 2ns;
        address_sim <= x"000B";
        wait for 2ns;
        address_sim <= x"000C";
        wait for 2ns;
        address_sim <= x"000D";
        wait for 2ns;
        address_sim <= x"000E";
        wait for 2ns;
        address_sim <= x"000F";
        wait for 2ns;
    end process;

end Behavioral;
