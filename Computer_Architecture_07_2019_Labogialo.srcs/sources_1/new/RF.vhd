----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/03/2018 10:39:03 AM
-- Design Name: 
-- Module Name: RF - Behavioral
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
USE ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           CDB_Q : in STD_LOGIC_VECTOR (4 downto 0);
           ROB_R_Dest : in STD_LOGIC_VECTOR (4 downto 0);
           Rk_addr : in STD_LOGIC_VECTOR (4 downto 0);
           Rj_addr : in STD_LOGIC_VECTOR (4 downto 0);         
           Value : in STD_LOGIC_VECTOR (31 downto 0);
           RS_ID : in STD_LOGIC_VECTOR (4 downto 0);
           
           Qk_out :out STD_LOGIC_VECTOR (4 downto 0);
           Qj_out :out STD_LOGIC_VECTOR (4 downto 0);
           Rk_V : out STD_LOGIC_VECTOR (31 downto 0);
           Rj_V : out STD_LOGIC_VECTOR (31 downto 0));
end RF;

architecture Behavioral of RF is
SIGNAL R_in_tmp: STD_LOGIC_VECTOR(31 DOWNTO 0);  



type t_Memory is array (0 to 31) of std_logic_vector(31 downto 0);
signal R_out_tmp : t_Memory;
type t1_Memory is array (0 to 31) of std_logic_vector(4 downto 0);
signal RF_Q_OUT_TMP,R_Q_in_tmp : t1_Memory;   
type t2_Memory is array (0 to 31) of std_logic;
signal EN_TMP : t2_Memory;          



COMPONENT RF_PART  
  Port ( clk : in STD_LOGIC;
         En : in STD_LOGIC;
         R_in : in STD_LOGIC_VECTOR (31 downto 0);   -- auth h timh tha mpei apo cdb ean, ekeinh thn stigmh den exei zhthsei o issue gia eggrafh, epishs tha mpei kai an thn thelei san e3odo to ISSUE(rk,rj) kai apla tha ginei forward apo to cdb_v kateutheian sthn e3odo tou rk,rj, gia na mhn paroume thn palia timh
         RF_Q_IN : IN STD_LOGIC_VECTOR (4 downto 0);  ---E3artatai, ama cdb_q = *R_in* , tote antikathistw to RS_num(ID)
         rst : in STD_LOGIC;
         RF_Q_OUT : out STD_LOGIC_VECTOR (4 downto 0);
         R_OUT : OUT STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT;

begin

R0: RF_PART
Port Map (clk     =>clk,
          en      => '1',      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>"00000000000000000000000000000000",  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>"11111",--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(0),--e3odos tou pediou Q
          R_out   =>r_OUT_TMP(0)); --ejodos ths timhs tou Reg

R1: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(1),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(1),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(1),--e3odos tou pediou Q
          R_out   =>R_out_tmp(1)); --ejodos ths timhs tou Reg

R2: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(2),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(2),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(2),--e3odos tou pediou Q
          R_out   =>R_out_tmp(2)); --ejodos ths timhs tou Reg

R3: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(3),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(3),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(3),--e3odos tou pediou Q
          R_out   =>R_out_tmp(3)); --ejodos ths timhs tou Reg
          
R4: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(4),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(4),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(4),--e3odos tou pediou Q
           R_out   =>R_out_tmp(4)); --ejodos ths timhs tou Reg


R5: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(5),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(5),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(5),--e3odos tou pediou Q
           R_out   =>R_out_tmp(5)); --ejodos ths timhs tou Reg

R6: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(6),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(6),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(6),--e3odos tou pediou Q
           R_out   =>R_out_tmp(6)); --ejodos ths timhs tou Reg


R7: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(7),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(7),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(7),--e3odos tou pediou Q
           R_out   =>R_out_tmp(7)); --ejodos ths timhs tou Reg




R8: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(8),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(8),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(8),--e3odos tou pediou Q
           R_out   =>R_out_tmp(8)); --ejodos ths timhs tou Reg


R9: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(9),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(9),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(9),--e3odos tou pediou Q
           R_out   =>R_out_tmp(9)); --ejodos ths timhs tou Reg

R10: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(10),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(10),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(10),--e3odos tou pediou Q
           R_out   =>R_out_tmp(10)); --ejodos ths timhs tou Reg

R11: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(11),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(11),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(11),--e3odos tou pediou Q
          R_out   =>R_out_tmp(11)); --ejodos ths timhs tou Reg

R12: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(12),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(12),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(12),--e3odos tou pediou Q
          R_out   =>R_out_tmp(12)); --ejodos ths timhs tou Reg

R13: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(13),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(13),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(13),--e3odos tou pediou Q
          R_out   =>R_out_tmp(13)); --ejodos ths timhs tou Reg
          
R14: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(14),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(14),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(14),--e3odos tou pediou Q
           R_out   =>R_out_tmp(14)); --ejodos ths timhs tou Reg


R15: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(15),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(15),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(15),--e3odos tou pediou Q
           R_out   =>R_out_tmp(15)); --ejodos ths timhs tou Reg

R16: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(16),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(16),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(16),--e3odos tou pediou Q
           R_out   =>R_out_tmp(16)); --ejodos ths timhs tou Reg


R17: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(17),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(17),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(17),--e3odos tou pediou Q
           R_out   =>R_out_tmp(17)); --ejodos ths timhs tou Reg




R18: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(18),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(18),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(18),--e3odos tou pediou Q
           R_out   =>R_out_tmp(18)); --ejodos ths timhs tou Reg


R19: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(19),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(19),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(19),--e3odos tou pediou Q
           R_out   =>R_out_tmp(19)); --ejodos ths timhs tou Reg

R20: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(20),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(20),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(20),--e3odos tou pediou Q
           R_out   =>R_out_tmp(20)); --ejodos ths timhs tou Reg

R21: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(21),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(21),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(21),--e3odos tou pediou Q
          R_out   =>R_out_tmp(21)); --ejodos ths timhs tou Reg

R22: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(22),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(22),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(22),--e3odos tou pediou Q
          R_out   =>R_out_tmp(22)); --ejodos ths timhs tou Reg

R23: RF_PART
Port Map (clk     =>clk,
          en      => en_tmp(23),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
          R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
          Rf_Q_in =>R_Q_in_tmp(23),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
          rst     =>rst,
          Rf_q_out=>Rf_q_out_tmp(23),--e3odos tou pediou Q
          R_out   =>R_out_tmp(23)); --ejodos ths timhs tou Reg
          
R24: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(24),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(24),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(24),--e3odos tou pediou Q
           R_out   =>R_out_tmp(24)); --ejodos ths timhs tou Reg


R25: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(25),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(25),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(25),--e3odos tou pediou Q
           R_out   =>R_out_tmp(25)); --ejodos ths timhs tou Reg

R26: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(26),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(26),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(26),--e3odos tou pediou Q
           R_out   =>R_out_tmp(26)); --ejodos ths timhs tou Reg


R27: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(27),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(27),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(27),--e3odos tou pediou Q
           R_out   =>R_out_tmp(27)); --ejodos ths timhs tou Reg




R28: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(28),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(28),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(28),--e3odos tou pediou Q
           R_out   =>R_out_tmp(28)); --ejodos ths timhs tou Reg


R29: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(29),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(29),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(29),--e3odos tou pediou Q
           R_out   =>R_out_tmp(29)); --ejodos ths timhs tou Reg

R30: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(30),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(30),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(30),--e3odos tou pediou Q
           R_out   =>R_out_tmp(30)); --ejodos ths timhs tou Reg

R31: RF_PART
 Port Map (clk     =>clk,
           en      => en_tmp(31),      --sundiasmos twn 2 enable pou erxontai apo issue and cdb
           R_in    =>R_in_tmp,  --H timh eisodou gia na bgei sthn e3odo sto epomeno clk
           Rf_Q_in =>R_Q_in_tmp(31),--h timh eisodou Q apo cdb,gia na bgei sthn ejodo
           rst     =>rst,
           Rf_q_out=>Rf_q_out_tmp(31),--e3odos tou pediou Q
           R_out   =>R_out_tmp(31)); --ejodos ths timhs tou Reg

Rf_proc : PROCESS(CLK,ROB_R_Dest,Rk_addr,Rj_addr,R_out_tmp,Value)
variable cdb_q_num,R_Dest_num, i, Rk_addr_num,Rj_addr_num  : integer;
BEGIN   
cdb_Q_num:=0;                          
R_Dest_num := to_integer(signed(ROB_R_dest));
Rk_addr_num:= to_integer(signed(Rk_addr));
Rj_addr_num := to_integer(signed(Rj_addr));
for i in 0 to 31 loop
    en_tmp(i)<='0';  
    if(ROB_R_dest = "00000") then null;   ---otan o rob1 den einai ready, kai den exei bgei akoma ston cdb to value me id rob1(wste na steiloume to destination tou rob1 me value auth tou cdb),otan tha einai diafora apo asous, tote shmainei pws to alla3e o rob auto kathws einai to value tou destination sto cdb
    else                                   ------------Register_dest,erxetai apo ROB1 otan einai ready, h sto corner case,otan diladh den einai ready(brisketai sthn thesh rob1) alla o cdb tuxainei na exei thn timh kai thn pairnoume kateuetheian apo ton cdb.             
         R_in_tmp <= Value;                  -----ATTENTION!!!!!! Auto to value, orizetai apo ton mc,autos tha apofasisei an ferei thn timh apo cdb h to value tou rob(dioti mporei na einai ready h rob1, kai to cdb na fernei ena apotelemsa px gia to rob4, opote anagkastika den xrhsimoupoiume ton cdb)
         en_tmp(R_Dest_num)<='1';                    
    end if;
end loop;
 
Rk_v <=R_out_tmp(Rk_addr_num) ;  --kanonikh e3odos (tha epilextei apo ton MC an apofasisei oti den ta exei kapoios ws R_dest ston ROB)
Rj_v <=R_out_tmp(Rj_addr_num) ;  --kanonikh e3odos

END PROCESS;

end Behavioral;
