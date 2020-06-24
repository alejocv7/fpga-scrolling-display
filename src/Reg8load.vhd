-----------------------------------------------------
-- Reg8load.vhd - Alejandro Cañizares - 11/11/2018 
-- Eight bit loadable register
-----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Reg8load is
    Port ( clk,clr,load : in  STD_LOGIC;
           Di : in  STD_LOGIC_VECTOR (7 downto 0);
           Qo : out STD_LOGIC_VECTOR (7 downto 0));
end Reg8load;

architecture Behavioral of Reg8load is
    signal Qi : STD_LOGIC_VECTOR (7 downto 0);
begin
    process(clk,clr)
    begin
        if clr = '1' then
            Qi <= (others=>'0');
        elsif rising_edge(clk) and load = '1' then
            Qi <= Di;
        end if;
    end process;
    
    -- Output logic
    Qo <= Qi;

end Behavioral;