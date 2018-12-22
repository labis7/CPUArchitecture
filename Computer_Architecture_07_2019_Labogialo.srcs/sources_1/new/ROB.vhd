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
         CDB_Q  : in STD_LOGIC_VECTOR (4 downto 0); -- itan 31 bits ...giati?
         PC_in  : in STD_LOGIC_VECTOR (31 downto 0);
         Opcode_in : in STD_LOGIC_VECTOR (3 downto 0); --4 bit. type kai op
         R_dest : in STD_LOGIC_VECTOR (4 downto 0);
         Rk     : in STD_LOGIC_VECTOR (4 downto 0);
         Rj     : in STD_LOGIC_VECTOR (4 downto 0);
         En     : in STD_LOGIC;
         
         
         
         --out
         ROB1_ID      : out STD_LOGIC_VECTOR (4 downto 0);                                                     --pigainoun MC gia na apofasisei an diale3ei auta h ton CDB kateutheian se ena corner case(blepe MC sxolia)
         ROB1_RES      : out STD_LOGIC_VECTOR (31 downto 0);  --pigainoun MC gia na apofasisei an diale3ei auta h ton CDB kateutheian se ena corner case(blepe MC sxolia)
         ROB1_DEST     : out STD_LOGIC_VECTOR (4 downto 0);
         ready_out     : out STD_LOGIC;
         exception_code: out STD_LOGIC;
         Rob_ID        : out STD_LOGIC_VECTOR (4 downto 0);                    --Asyxrona stelnetai to ID tou rob slot sto opoio prokeitai na graftei h entolh pou exei erthei TWRA
         Qk            : out STD_LOGIC_VECTOR (4 downto 0);                    --auth h timh einai gia ta pedia q ths RS, h RS tha akouei sunexeia to cdb(opws kai kanei), wste na brei kapoio rob# na bouti3ei gia na to balei sta dedomena ths, pernaei prwta apo MC 
         Qj            : out STD_LOGIC_VECTOR (4 downto 0);                    --pernane prwta apo MC
         Vk            : out STD_LOGIC_VECTOR (31 downto 0);                    -- timh otan, ta q parapanw einai 11111(pou shmainei oti uparxei mesa ston ROB kai exei etoimh timh), to 00000 shmainei oti den uparxei(kai epilegoume RF gia ta values), enw se allh periptwsh ta Q koubalane to rob# pou perimenoume(V adiaforo)
         Vj            : out STD_LOGIC_VECTOR (31 downto 0));
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
signal top_s,bot_s : std_logic_vector (4 downto 0);
signal pc_s : std_logic_vector(31 downto 0);

begin
process (clk,top_s,bot_s,ready,r_dest,rk,rj,en,opcode_in,cdb_Q)
--variable pc_t : std_logic_vector (31 downto 0);
variable top : std_logic_vector (4 downto 0);             -- tha arxikopoihsoyme sto ROB1 (00000)   = bot
variable bot : std_logic_vector (4 downto 0);           -- tha arxikopoihsoyme sto ROB1 (00000)   = top
                                                          -- einai o deiktis poy mas deixnei se poio stoixeio ths fifo tha grapsoume   
begin

--RESET
--bot_S<="00000";
--TOP_S<="00000";
---------spasimo arxikhs
if((top_s(0) /='1') AND (top_s(0) /='0') ) THEN 
    pc_s<= "00000000000000000000000000000000";
    BOT := "00001";
    top := "00000";
    --ready(1) <= '0'; --3ekiname gia init apo 00000
    else
    top  := top_s;
    bot:=  bot_s;  --(start)
end if;






-----------------------------------------------------------------------------------------------------     
-- Issue --> ROB (erxetai apo issue kainourgia entoli kai prepei na kataxwrihei sto ROB)  
-----------------------------------------------------------------------------------------------------
   -- if en='1' then 
       
   
   
   
   
    if((top + "00001") /= bot) then
        for i in to_integer(unsigned(top)) downto to_integer(unsigned(bot)) loop  --na to kanoume while, thaxoume thema            --3ekinwntaw apo ta pio kainourgia,tha psa3oume thn teleutaia e3arthsh
            if (Dest(i) = Rk) then          
                if (ready(i) = '1') then
                    Vk <= Value(i);
                    Qk <= "11111";               --DESMEUMENOS kwdikos oti uparxei ston ROB, kai exoun kai thn timh
                elsif (ready(i)='0')and (CDB_Q = Dest(i)) then
                    Vk <= CDB_V;
                    Qk <= "11111";                 --corner case, molis irthe apo cdb
                else
                    Qk <= std_logic_vector(to_unsigned(i,5));
                end if;
                exit;
            elsif ( i = bot ) then   --ftasame sto ROB(bot-start) stoixeio
                Qk <= "11110";      -- DESMEUMENOS kwdikos pou deixnei oti den brikame to stoixeio pou psaxname,opote tha to epile3oume apo thn RF(douleia tou MC)
            else 
                null;
            end if;
        end loop;
         
        for i in to_integer(unsigned(top)) downto to_integer(unsigned(bot)) loop    --3ekinwntaw apo ta pio kainourgia,tha psa3oume thn teleutaia e3arthsh
            if (Dest(i) = Rj) then
                if (ready(i) = '1') then
                    Vj <= Value(i);
                    Qj <= "11111";              --DESMEUMENOS kwdikos oti uparxei ston ROB, kai exoun kai thn timh
                elsif (ready(i)='0')and (CDB_Q = Dest(i)) then
                    Vj <= CDB_V;
                    Qj <= "11111";              --corner case, molis irthe apo cdb
                else
                    Qj <= std_logic_vector(to_unsigned(i,5));
                end if;
                exit;
            elsif ( i = bot ) then
                Qj <= "11110";      -- DESMEUMENOS wdikos pou deixnei oti den brikame to stoixeio pou psaxname,opote tha to epile3oume apo thn RF(douleia tou MC)
            else 
                null;
            end if;
        end loop;
      
      else  --simainei pws htan adeio
        Qk <= "11110";
        Qj <= "11110";       
      end if;
        
        
      
  if clk'event  then    
       if((en='1')AND(CLK='1')) then   
            top := top_s + "00001";                                                           
            top := std_logic_vector(to_unsigned( ((to_integer(unsigned(top))) mod 30) , 5 )); 
            pc(to_integer(unsigned(top))) <= pc_s;
            pc_s<= pc_s + "00000000000000000000000000000100";
            Dest(to_integer(unsigned(top))) <= R_dest;
            ready(to_integer(unsigned(top))) <= '0';            -- ready = done , den uparxei periptwsi moliw mpei mia entoli apo issue na exoume apotelesmata sto value
            opcode(to_integer(unsigned(top))) <= Opcode_in;
            
            if ((opcode_in(3 downto 2) = "00") or (opcode_in(3 downto 2) = "01")) AND ((opcode_in(1 downto 0) = "00") or (opcode_in(1 downto 0) = "01")  or (opcode_in(1 downto 0) = "10")) then
               ex_stat(to_integer(unsigned(top))) <='0';
            else
               ex_stat(to_integer(unsigned(top))) <='1'; 
            end if; 
       end if;
      
      
             
            
     --apothikeush timhs  
--        top := top_s + "00001";
--        top := std_logic_vector(to_unsigned( ((to_integer(unsigned(top))) mod 30) , 5 ));

--        Rob_ID <= top;   --- e3odos tou ROB, gia na to parei 
--        Dest(to_integer(unsigned(top))) <= R_dest;
--        ready(to_integer(unsigned(top))) <= '0';            -- ready = done , den uparxei periptwsi moliw mpei mia entoli apo issue na exoume apotelesmata sto value
--        opcode(to_integer(unsigned(top))) <= Opcode_in;
--        pc(to_integer(unsigned(top))) <=pc_in;
--        if ((opcode_in(3 downto 2) = "00") or (opcode_in(3 downto 2) = "01")) AND ((opcode_in(1 downto 0) = "00") or (opcode_in(1 downto 0) = "01")  or (opcode_in(1 downto 0) = "10")) then
--           ex_stat(to_integer(unsigned(top))) <='0';
--        else
--           ex_stat(to_integer(unsigned(top))) <='1'; 
--        end if;       
        
  --  end if;     --(END_IF TOU ENABLE)
end if;         --(END_IF TOU CLOCK)


   -- if clk'event then--and clk = '1' then
   --     top := top_s + "00001";
    --    top := std_logic_vector(to_unsigned( ((to_integer(unsigned(top))) mod 30) , 5 ));
    --end if;
        
        Rob_ID <=std_logic_vector(to_unsigned( ((to_integer(unsigned(top + "00001"))) mod 30) , 5 )) ;   --- e3odos tou ROB, gia na to parei o RS (mesw tou MC)
        
---------------------------------------------------------------------------------------------------------------
----------------------------------------Distribute value of CDB where needed----------------------------------- 
---------------------------------------------------------------------------------------------------------------
if((top + "00001") /= bot) then  
    for i in to_integer(unsigned(top_s)) downto to_integer(unsigned(bot)) loop   -- apo to palio top 3ekiname, thewrwntas pws ta apo panw exoun kanei swsta to forward pou pithanon na dhmiourgouse thema
        ---den tha elegxoume gia to i==0 to corner case,pou o cdb efere twra thn timh, gt den mas noiazei na thn apothikeusoume kai na xasoume kuklo, h parapanw diadikasia to kalupse    
        if(to_integer(unsigned(CDB_Q)) = i)  THEN  -- brikame to ROB# pou xreiazetai to  value tou (apo ton cdb)
           Value(i) <=  CDB_V;                     --mporei na to xreiastoun perissotera apo 1 ,opote den kanoume kanena exit apo to loop
           Ready(i) <= '1';                        -- h katastash ginetai pleon ready
        end if;
    end loop;
end if;

---------------------------------------------------------------------------------------------------------------------------
----------------------------------------delete ROB1 (commited)  and bot++(bot erase)-----------------------------------
--------------------------------------------------------------------------------------------------------------- 
if clk'event and clk = '1' then
     if((((Opcode(to_integer(unsigned(bot)))(3 downto 2)/="01")and(Opcode(to_integer(unsigned(bot)))(3 downto 2)/="00"))OR((Opcode(to_integer(unsigned(bot)))(1 downto 0)/="00")AND(Opcode(to_integer(unsigned(bot)))(1 downto 0)/="01")AND(Opcode(to_integer(unsigned(bot)))(1 downto 0)/="10")))AND(opcode(to_integer(unsigned(bot)))(0)='0' or opcode(to_integer(unsigned(bot)))(0)='1')) then
        bot := std_logic_vector(to_unsigned( ((to_integer(unsigned(top + "00001"))) mod 30) , 5 )) ;  
    elsif((Ready(to_integer(unsigned(bot)))='1')or(CDB_Q = bot)) then          --elegxos gia to corner case tou i==bot(kai ready=1) kai tou cdb na exei ferei twra thn timh tou
        bot := bot_s + "00001";  
        bot := std_logic_vector(to_unsigned( ((to_integer(unsigned(bot))) mod 30) , 5 ));        
    else
        null;  
    end if;
end if;

--enhmerwsh twn out timws tou bot opws dest,ready_status k.a.
if clk'event and clk = '1' then
    rob1_id        <= bot;
    ROB1_RES       <= Value(to_integer(unsigned(bot)));
    ROB1_DEST      <= Dest(to_integer(unsigned(bot)));
    ready_out      <= ready(to_integer(unsigned(bot)));
    exception_code <= ex_stat(to_integer(unsigned(bot)));
end if;

-------------------------------
--telikh enhmerwsh tou neou top/start
-------------------------------
bot_s<=bot;
top_s<=top;


end process;

end Behavioral;
