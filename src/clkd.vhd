--------------------------------------------------
-- clkd.vhd - Alejandro Cañizares - 10/20/2018
-- Clock Divider
--------------------------------------------------
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clkd is 
	Generic ( clk_f  : INTEGER := 50e6;    -- Clock Real Frecuency in Hz
			  clk_df : INTEGER := 1  ); 	-- Clock Desired Frecuency in Hz			  
    Port ( clk_in, reset : in  STD_LOGIC ;
           clk_out 		 : out STD_LOGIC);	
end;

architecture synth of clkd is 		
-- Constants:
		constant NN : INTEGER := ( clk_f / (2*clk_df) - 1);	
		
-- Signals:	
		signal counter  : integer range 0 to NN := 0;
		signal temp_clk : STD_LOGIC;

-- Divider Process:
begin

	process (clk_in, reset) 	
	begin	
		if reset = '1' then			
			temp_clk  <= '1';
			counter   <=  0 ;			
		elsif rising_edge(clk_in) then
			if counter = NN then			   
			   temp_clk <= not( clk_out );
			   counter <= 0;				
			else
			   counter <= counter + 1;					
			end if;	
		end if;
	end process;
	
	clk_out <= temp_clk;
end;