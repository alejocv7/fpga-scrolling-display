------------------------------------------------------
-- in2_Reg8load.vhd - Alejandro Cañizares - 11/11/2018 
-- 2 input - Eight bit loadable register
------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity in2_Reg8load is
    Port ( clk, clr : in  STD_LOGIC;
           load     : in  STD_LOGIC_VECTOR (1 downto 0);
           Dy, F    : in  STD_LOGIC_VECTOR (7 downto 0);
           Qo       : out STD_LOGIC_VECTOR (7 downto 0));
end in2_Reg8load;

architecture Behavioral of in2_Reg8load is
    signal Qi : STD_LOGIC_VECTOR (7 downto 0);
begin
    process(clk,clr)
    begin
        if clr = '1' then
            Qi <= (others=>'0');
        elsif rising_edge(clk) then
            if (load = "01" or load = "11") then
                Qi <= F;   
            elsif load = "10" then
                Qi <= Dy;
            end if;
        end if;
    end process;
    
    -- Output logic
    Qo <= Qi;

end Behavioral;