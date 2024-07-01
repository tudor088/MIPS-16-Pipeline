library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MPG_sim is
--  Port ( );
end MPG_sim;

architecture Behavioral of MPG_sim is

    component MPG is
    Port ( btn : in STD_LOGIC;
          clk : in STD_LOGIC;
          en : out STD_LOGIC
    );
    end component MPG;
    
    signal clk_sim: std_logic;
    signal btn_sim: std_logic;
    signal enable_sim: std_logic;
    
    begin
    enable_sim <= '0';
    mpg_init: MPG port map(btn_sim, clk_sim, enable_sim);
    
    
    simulateClk: process
    begin
        loop
            clk_sim <= '0';
            wait for 1ns;
            clk_sim <= '1';
            wait for 1ns;
        end loop;
    end process;
    
    sim: process
    begin
        btn_sim <= '1';
        wait for 2ns;
        btn_sim <= '0';
        wait for 8ns;
        btn_sim <= '1';
        wait for 3ns;
        btn_sim<='0';
        wait for 2ns;
        btn_sim <= '1';
        wait for 8ns;
    end process;

end Behavioral;
