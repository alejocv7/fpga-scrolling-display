---------------------------------------------------------
-- in2_Reg8load_tb.vhd - Alejandro Cañizares - 11/11/2018 
-- 2 input - Eight bit loadable register - Testbench
---------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity in2_Reg8load_tb is
end;

architecture bench of in2_Reg8load_tb is

  component in2_Reg8load
      Port ( clk, clr : in  STD_LOGIC;
             load     : in  STD_LOGIC_VECTOR (1 downto 0);
             Dy, F    : in  STD_LOGIC_VECTOR (7 downto 0);
             Qo       : out STD_LOGIC_VECTOR (7 downto 0));
  end component;

  signal clk, clr : STD_LOGIC := '1';
  signal load     : STD_LOGIC_VECTOR (1 downto 0);
  signal Dy, F    : STD_LOGIC_VECTOR (7 downto 0);
  signal Qo       : STD_LOGIC_VECTOR (7 downto 0);

begin

  uut: in2_Reg8load port map ( clk  => clk,
                               clr  => clr,
                               load => load,
                               Dy   => Dy,
                               F    => F,
                               Qo   => Qo );
                               
  clk <= not clk  after 50 ns;
  clr <= '1', '0' after 50 ns;
   
  load_stimulus: process
  begin
    load <= "01"; wait for 200 ns;
    load <= "10"; wait for 200 ns;
    load <= "11"; wait for 200 ns;
    load <= "10"; wait for 200 ns;
    load <= "00"; wait for 200 ns;
  end process;
  
  Dy_stimulus: process
  begin
    Dy <= "00000000"; wait for 300 ns;
    Dy <= "01111111"; wait for 300 ns;
    Dy <= "10000000"; wait for 300 ns;
    Dy <= "11111111"; wait for 300 ns;
  end process;
  
  F_stimulus: process
  begin
    F <= "11000000"; wait for 300 ns;
    F <= "00000001"; wait for 300 ns;
    F <= "00000000"; wait for 300 ns;
    F <= "00000011"; wait for 300 ns;
  end process;
end bench;