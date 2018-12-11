----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2018 11:14:00 AM
-- Design Name: 
-- Module Name: ROB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROB is
  Port ( CLK    :IN STD_LOGIC;
         CDB_V  : in STD_LOGIC_VECTOR (31 downto 0);
         CDB_Q  : in STD_LOGIC_VECTOR (31 downto 0);
         PC_in  : in STD_LOGIC_VECTOR (31 downto 0);
         Opcode_in : in STD_LOGIC_VECTOR (3 downto 0); --4 bit. type kai op
         R_dest : in STD_LOGIC_VECTOR (4 downto 0);
         Rk     : in STD_LOGIC_VECTOR (4 downto 0);
         Rj     : in STD_LOGIC_VECTOR (4 downto 0);
         En     : in STD_LOGIC;
         
         
         
         --out
         ROB1_RES      : out STD_LOGIC_VECTOR (31 downto 0);  --pigainoun MC gia na apofasisei an diale3ei auta h ton CDB kateutheian se ena corner case(blepe MC sxolia)
         ROB1_DEST     : out STD_LOGIC_VECTOR (4 downto 0);
         ready_out     : out STD_LOGIC;
         exception_code: out STD_LOGIC;
         Rob_ID        : out STD_LOGIC_VECTOR (4 downto 0);                    --Asyxrona stelnetai to ID tou rob slot sto opoio prokeitai na graftei h entolh pou exei erthei TWRA
         Qk            : out STD_LOGIC_VECTOR (4 downto 0);                    --auth h timh einai gia ta pedia q ths RS, h RS tha akouei sunexeia to cdb(opws kai kanei), wste na brei kapoio rob# na bouti3ei gia na to balei sta dedomena ths, pernaei prwta apo MC 
         Qj            : out STD_LOGIC_VECTOR (4 downto 0);                    --pernane prwta apo MC
         Vk            : out STD_LOGIC_VECTOR (31 downto 0);                    -- timh otan, ta q parapanw einai 11111(pou shmainei oti uparxei mesa ston ROB kai exei etoimh timh), to 00000 shmainei oti den uparxei(kai epilegoume RF gia ta values), enw se allh periptwsh ta Q koubalane to rob# pou perimenoume(V adiaforo)
         Vj            : out STD_LOGIC_VECTOR (31 downto 0)

);
end ROB;

architecture Behavioral of ROB is

        
type bit_32  is array (31 downto 0) of std_logic_vector (31 downto 0);         
type bit_5   is array (31 downto 0) of std_logic_vector (4 downto 0);
type bit_4   is array (31 downto 0) of std_logic_vector (3 downto 0);
type bit_1   is array (31 downto 0) of std_logic;



signal Value,pc       : bit_32;           
signal Dest           : bit_5;
signal opcode         : bit_4; 
signal ready,ex_stat  : bit_1;
signal top_s          : std_logic_vector (4 downto 0);

begin
process (clk)
variable top : std_logic_vector (4 downto 0);             -- tha arxikopoihsoyme sto ROB1 (00000)       
                                                          -- einai o deiktis poy mas deixnei se poio stoixeio ths fifo tha grapsoume   
begin

top := top_s;

if clk'event and clk = '1' then
-----------------------------------------------------------------------------------------------------     
-- Issue --> ROB (erxetai apo issue kainourgia entoli kai prepei na aktaxwrihei sto ROB)  
-----------------------------------------------------------------------------------------------------
    if en='1' then 
        for i in to_integer(unsigned(top)) to 1 loop              --3ekinwntaw apo ta pio kainourgia,tha psa3oume thn teleutaia e3arthsh
            if (Dest(i) = Rk) then          
                if (ready(i) = '1') then
                    Vk <= Value(i);
                    Qk <= "11111";               --kwdikos oti uparxei ston ROB, kai exoun kai thn timh
                elsif (ready(i)='0')and (CDB_Q = Dest(i)) then
                    Vk <= CDB_V;
                    Qk <= "11111";                 --corner case, molis irthe apo cdb
                else
                    Qk <= std_logic_vector(to_unsigned(i,5));
                end if;
                exit;
            elsif ( i = 1 ) then   --ftasame sto ROB1 stoixeio
                Qk <= "00000";      -- kwdikos pou deixnei oti den brikame to stoixeio pou psaxname,opote tha to epile3oume apo thn RF(douleia tou MC)
            else 
                null;
            end if;
        end loop;
         
        for i in to_integer(unsigned(top)) to 1 loop    --3ekinwntaw apo ta pio kainourgia,tha psa3oume thn teleutaia e3arthsh
            if (Dest(i) = Rj) then
                if (ready(i) = '1') then
                    Vj <= Value(i);
                    Qj <= "11111";              --kwdikos oti uparxei ston ROB, kai exoun kai thn timh
                elsif (ready(i)='0')and (CDB_Q = Dest(i)) then
                    Vk <= CDB_V;
                    Qk <= "11111";              --corner case, molis irthe apo cdb
                else
                    Qj <= std_logic_vector(to_unsigned(i,5));
                end if;
                exit;
            elsif ( i = 1 ) then
                Qj <= "00000"; 
            else 
                null;
            end if;
        end loop;
        
        
        
     --apothikeush timhs       
        top := top_s+"00001";
        Rob_ID <= top_s+"00001";   --- e3odos tou ROB, gia na to parei 
        Dest(to_integer(unsigned(top))) <= R_dest;
        ready(to_integer(unsigned(top))) <= '0';            -- ready = done , den uparxei periptwsi moliw mpei mia entoli apo issue na exoume apotelesmata sto value
        opcode(to_integer(unsigned(top))) <= Opcode_in;
        pc(to_integer(unsigned(top))) <=pc_in;
        if (opcode_in(3 downto 2) /= "00") or (opcode_in(3 downto 2) /= "01") or (opcode_in(1 downto 0) /= "00") or (opcode_in(1 downto 0) /= "01")  or (opcode_in(1 downto 0) /= "10") then
           ex_stat(to_integer(unsigned(top))) <='1';
        else
           ex_stat(to_integer(unsigned(top))) <='0'; 
        end if;  
        
     
     
       
       
          
    end if;     --(END_IF TOU ENABLE)
end if;         --(END_IF TOU CLOCK)


---------------------------------------------------------------------------------------------------------------
----------------------------------------Distribute value of CDB where needed----------------------------------- 
---------------------------------------------------------------------------------------------------------------

for i in to_integer(unsigned(top_s)) to 1 loop   -- apo to palio top 3ekiname, thewrwntas pws ta apo panw exoun kanei swsta to forward pou pithanon na dhmiourgouse thema
    ---den tha elegxoume gia to i==0 to corner case,pou o cdb efere twra thn timh, gt den mas noiazei na thn apothikeusoume kai na xasoume kuklo, h parapanw diadikasia to kalupse    
    if(to_integer(unsigned(CDB_Q) = i) THEN  -- brikame to ROB# pou xreiazetai to  value tou (apo ton cdb)
        
     
    end if;

end loop;



---------------------------------------------------------------------------------------------------------------------------
----------------------------------------delete ROB1 (commited)  and shift everything else-----------------------------------
--------------------------------------------------------------------------------------------------------------- 

--elegxos gia to corner case tou i==1 kai tou cdb na exei ferei twra thn timh tou




end process;

end Behavioral;
