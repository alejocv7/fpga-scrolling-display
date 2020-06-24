----------------------------------------------------
-- ROM.vhd - Alejandro Cañizares - 12/11/2018 
-- ROM
----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity ROM is
    Port ( ROM_Add  : in std_logic_vector(3 downto 0);
           EnROM    : in std_logic;
           ROM_Data : out std_logic_vector(7 downto 0));
end ROM;

architecture Arch of ROM is

-- Internal signals
    signal AddressI : integer range 0 to 15;

-- MicroStore    
    subtype MREC is std_logic_vector (7 downto 0);
	type MSTORE is array (0 to 15) of MREC;
	
    constant MROM : MSTORE :=  (
            -- - abc_defg
             B"0_100_1000",  -- H -- X"48"
             B"0_000_1000",  -- A -- X"08"
             B"0_001_1000",  -- P -- X"18"
             B"0_001_1000",  -- P -- X"18"
             B"0_100_0100",  -- Y -- X"44"
             B"0_111_1111",  -- _ -- X"7F"
             B"0_100_0010",  -- d -- X"42"
             B"0_000_1000",  -- A -- X"08"
             B"0_100_0100",  -- Y -- X"44"
             B"0_111_1111",  -- _ -- X"7F"
             B"0_111_1110",  -- - -- X"7E" 
             B"0_111_1111",  -- _ -- X"7F"
             --------------------
             B"0_111_1111",  -- _ -- X"7F"
             B"0_111_1111",  -- _ -- X"7F"
             B"0_111_1111",  -- _ -- X"7F"
             B"0_111_1111"); -- _ -- X"7F"
             --------------------  
begin
    -- Read the memory and pick out the fields
        AddressI <= to_integer(unsigned (ROM_Add));
        
        process(AddressI, EnROM)
        begin
            if EnROM = '1' then
                ROM_Data <= MROM(AddressI);
            else 
                ROM_Data <= (others=>'1');
            end if;
        end process;
     
end Arch;