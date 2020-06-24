-----------------------------------------------
-- Dpath.vhd - Alejandro Cañizares - 12/11/2018 
-- Data Path
-----------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity Dpath is
    Port ( clk, clr      : in  STD_LOGIC;
           Minput_vector : in  STD_LOGIC_VECTOR (17 downto 0);
           Dy, SWX       : in  STD_LOGIC_VECTOR (7 downto 0);
           Ax, Dx        : out STD_LOGIC_VECTOR (7 downto 0);
           LEDS          : out STD_LOGIC_VECTOR (7 downto 0);
           CF, ZF        : out STD_LOGIC);
end Dpath;

architecture Arch of Dpath is

-- Components
    component Reg8load is
        Port ( clk,clr,load : in  STD_LOGIC;
               Di           : in  STD_LOGIC_VECTOR (7 downto 0);
               Qo           : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component in2_Reg8load is
        Port ( clk, clr : in  STD_LOGIC;
               load     : in  STD_LOGIC_VECTOR (1 downto 0);
               Dy, F    : in  STD_LOGIC_VECTOR (7 downto 0);
               Qo       : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

-- Controller Signals 
    signal EnA, EnN, EnL           : STD_LOGIC;                     -- Enables
    signal En_D, SelMux, SelAlu    : STD_LOGIC_VECTOR (1 downto 0); -- Selects
    signal KVAL                    : STD_LOGIC_VECTOR (7 downto 0); -- External Inputs

-- Data path signals
    signal A, D, N_X, L, MUX_Y, F  : STD_LOGIC_VECTOR (7 downto 0);
        
begin
        
-- Defining signals from the controller:
    EnA    <= Minput_vector(17); 
    En_D   <= Minput_vector(16 downto 15);
    EnN    <= Minput_vector(14); 
    EnL    <= Minput_vector(13);
    SelMux <= Minput_vector(12 downto 11);
    SelAlu <= Minput_vector(10 downto 9);
    KVAL   <= Minput_vector(8 downto 1);
    
-- Register-A:
    regA: Reg8load 
          port map (clk=>clk, clr=>clr, load=>EnA, Di=>F, Qo=>A);
    Ax <= A;
-- Register-D:
    regD: in2_Reg8load 
          port map (clk=>clk, clr=>clr, load=>En_D, Dy=>Dy, F=>F, Qo=>D);
    Dx <= D;   
-- Register N:
    regN: Reg8load 
          port map (clk=>clk, clr=>clr, load=>EnN, Di=>F, Qo=>N_X);
-- Register L:
    regL: Reg8load 
          port map (clk=>clk, clr=>clr, load=>EnL, Di=>F, Qo=>L);
    LEDS <= L;

-- Multiplexer:
    with SelMux select
    MUX_Y <= A     when "00",
             D     when "01",
             KVAL  when "10",
             SWX   when "11",
             X"XX" when others;   
                     
-- ALU:
    with SelAlu select
    F <= N_X + MUX_Y     when "00",
         N_X - MUX_Y     when "01",
         MUX_Y           when "10",
         not MUX_Y       when "11",
         X"XX"           when others;
         
    -- ZF process:
        process(F, SelAlu)
        begin
            if (SelAlu = "01" and F = 8X"0") then
                ZF <= '1';
            else
                ZF <= '0';
            end if;
        end process;  
              
    -- CF process:
        process(SelAlu)
            variable F9 : std_logic_vector(8 downto 0);
        begin
            if SelAlu = "00" then
               F9 := ('0' & N_X) + ('0' & MUX_Y);
            elsif SelAlu = "01" then
               F9 := ('0' & N_X) - ('0' & MUX_Y);
            else
               F9 := 9X"0";
            end if;
        CF <= F9(8);
        end process;
        
end Arch;