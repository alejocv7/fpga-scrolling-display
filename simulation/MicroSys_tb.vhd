---------------------------------------------------------
-- MicroSys_tb.vhd - Alejandro Cañizares - 11/11/2018 
-- MicroSys Testbench
---------------------------------------------------------
library IEEE;
use IEEE.Std_logic_1164.all;

entity MicroSys_tb is
end;

architecture bench of MicroSys_tb is

  component MicroSys is
      Port ( clk_in, clr_in    : in  STD_LOGIC;
             S5,S4,S3,S2,S1,S0 : out STD_LOGIC_VECTOR (6 downto 0));
  end component;

  signal clk_in  : STD_LOGIC := '1';
  signal clr_in  : STD_LOGIC;
  signal S5,S4,S3,S2,S1,S0   : STD_LOGIC_VECTOR (6 downto 0);
  
begin

  uut: MicroSys port map ( clk_in=>clk_in, clr_in=>clr_in,
                           S5=>S5, S4=>S4, S3=>S3,
                           S2=>S2, S1=>S1, S0=>S0);    
                                                      
  clk_in <= not clk_in  after 20 ns;
  clr_in <= '0', '1' after 40 ns;
  
  process 
  begin
    wait;
  end process;
  
end bench;