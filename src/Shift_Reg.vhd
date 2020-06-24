----------------------------------------------------
-- Shift_Reg.vhd - Alejandro Cañizares - 12/11/2018 
-- Shif Register
----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Shift_Reg is
    Port ( clk,clr,EnSR,Wr : in std_logic;
           Dx : in std_logic_vector(7 downto 0);
           S5,S4,S3,S2,S1,S0 : out std_logic_vector(6 downto 0));         
end Shift_Reg;

architecture Arch of Shift_Reg is
  
begin
    process(clk,clr) 
    begin
        if clr = '1' then
            S5 <= (others => '1');
            S4 <= (others => '1');
            S3 <= (others => '1');
            S2 <= (others => '1');
            S1 <= (others => '1');
            S0 <= (others => '1');
        elsif rising_edge(clk) then
            if (EnSR = '1' and Wr = '1') then
                S5 <= S4;
                S4 <= S3;
                S3 <= S2;
                S2 <= S1;
                S1 <= S0;
                S0 <= Dx(6 downto 0);
            end if;
        end if;
    end process;

     
end Arch;