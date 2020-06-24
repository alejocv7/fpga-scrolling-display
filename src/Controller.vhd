----------------------------------------------------
-- Controller.vhd - Alejandro Cañizares - 12/11/2018 
-- Control Unit
----------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Controller is
    Port ( clk, clr      : in  STD_LOGIC;
           CF, ZF        : in  STD_LOGIC;
           Minput_vector : out STD_LOGIC_VECTOR (17 downto 0));
end Controller;

architecture Arch of controller is

-- Internal signals
    signal Address, Natt : std_logic_vector (3 downto 0);
    signal Test          : std_logic_vector (1 downto 0);
    signal load          : std_logic;
    signal AddressI      : integer range 0 to 7;

-- MicroStore    
    subtype MREC is std_logic_vector (23 downto 0);
	type MSTORE is array (0 to 7) of MREC;
	
    constant MROM : MSTORE :=  (
    --      Test  Natt  EnA En_D EnN EnL SMux SAlu  KVAL   Wr
            "00"&"0000"&'1'&"00"&'0'&'0'&"10"&"10"&8X"00"&'0',  -- $0
            "00"&"0000"&'0'&"00"&'1'&'0'&"00"&"10"&8O"00"&'0',  -- $1
            "00"&"0000"&'0'&"10"&'1'&'0'&"10"&"00"&8O"01"&'0',  -- $2
            "11"&"0000"&'0'&"00"&'0'&'0'&"10"&"01"&8D"12"&'0',  -- $3 
            "00"&"0000"&'1'&"00"&'0'&'0'&"10"&"10"&8X"80"&'0',  -- $4
            "00"&"0000"&'0'&"00"&'0'&'0'&"00"&"00"&8O"00"&'1',  -- $5
            "01"&"0001"&'1'&"00"&'0'&'0'&"10"&"00"&8O"00"&'0',  -- $6
            "00"&"0000"&'0'&"00"&'0'&'0'&"00"&"00"&8O"00"&'0');      
begin

    -- Read the memory and pick out the fields
        AddressI      <= to_integer(unsigned(Address));
        Test          <= MROM(AddressI)(23 downto 22);
        Natt          <= MROM(AddressI)(21 downto 18);
        -- Data-path vector: EnA & En_D & EnN & EnL & SelMux & SelAlu & KVAL & Wr:
        Minput_vector <= MROM(AddressI)(17 downto 0);  

    -- Counter
        process(clk,clr)
        begin
            if clr = '1' then
                Address <= (others => '0');
            elsif rising_edge(clk) then
                if load = '1' then 
                   Address <= Natt;
                else 
                   Address <= Address + '1';
                end if;
            end if;
        end process;
        
    -- Multiplexer Test:
        with Test select
        load <= '0' when "00",
                '1' when "01",
                CF  when "10",
                ZF  when "11",
                'X' when others;    	
end Arch;