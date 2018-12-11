----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/16/2018 11:45:09 AM
-- Design Name: 
-- Module Name: MC_RS_FU_A - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MC_RS_FU_A is
    Port ( clk : in STD_LOGIC;
           Grand_in_A: in STD_LOGIC;
           Vk        : in STD_LOGIC_VECTOR (31 downto 0);  --APO ISSUE
           Vj        : in STD_LOGIC_VECTOR (31 downto 0);  --APO ISSUE
           Qk        : in STD_LOGIC_VECTOR (4 downto 0);  --APO ISSUE. THA EXEI PAREI TIMH EGJURH,AN VK,VJ DEN EXOUN TIMES KAI TIS ANAMENOUN APO KAPOIO ID
           Qj        : in STD_LOGIC_VECTOR (4 downto 0);  --APO ISSUE
           CDB_V     : in STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q     : in STD_LOGIC_VECTOR (4 downto 0);
           OpCode    : in STD_LOGIC_VECTOR (4 downto 0); --apo issue, me 5o bit nanai panta '0' (busy)
           Stop          : in STD_LOGIC;
           ID_ROB_RS: in  STD_LOGIC_VECTOR (4 downto 0);
          
           Poke_out_A: out STD_LOGIC;
           Res_A     : out STD_LOGIC_VECTOR (31 downto 0);
           ID_A_OUT  : out STD_LOGIC_VECTOR (4 downto 0);   --POU THA TO BLEPEI TO ISSUE GIA NA TO BALEI STON ANTISTOIXO REG POU PERIMENEI APOTELESMA
           Tag_A     : out STD_LOGIC_VECTOR (4 downto 0);       -- GIA THN FU
           Free_A    : out STD_LOGIC
           );                         --THA EINAI UPEUTHUNO GIA THN ENERGOPOIHSH THS ROHS TWN NEWN ENTOLVN KAI TOU EN THS RS
end MC_RS_FU_A;

architecture Behavioral of MC_RS_FU_A is

COMPONENT  RS_Arithmetic
    Port ( CLK             : in  STD_LOGIC;
           EN_RS1          : in  STD_LOGIC_VECTOR(2 downto 0);
		   EN_RS2          : in  STD_LOGIC_VECTOR(2 downto 0);
		   EN_RS3          : in  STD_LOGIC_VECTOR(2 downto 0);
		   --Free_in         : in  STD_LOGIC_VECTOR(2 downto 0);  
		    	  
           OpCode_RS1_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           OpCode_RS2_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           OpCode_RS3_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           		  
		   Qk_RS1_IN       : in  STD_LOGIC_VECTOR (4 downto 0);
           Qk_RS2_IN       : in  STD_LOGIC_VECTOR (4 downto 0);
           Qk_RS3_IN       : in  STD_LOGIC_VECTOR (4 downto 0);
	       Qj_RS1_IN       : in  STD_LOGIC_VECTOR (4 downto 0);
           Qj_RS2_IN       : in  STD_LOGIC_VECTOR (4 downto 0);
           Qj_RS3_IN       : in  STD_LOGIC_VECTOR (4 downto 0);
			  
		   Vk_RS1_IN       : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk_RS2_IN       : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk_RS3_IN       : in  STD_LOGIC_VECTOR (31 downto 0);
		   Vj_RS1_IN       : in  STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS2_IN       : in  STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS3_IN       : in  STD_LOGIC_VECTOR (31 downto 0);
			 ID_ROB_RS : in  STD_LOGIC_VECTOR (4 downto 0);
			  
			  
		   Rb :   out  STD_LOGIC_VECTOR (2 downto 0);
		   Free_out   : out  STD_LOGIC_VECTOR(2 downto 0);  
 	  
		   OpCode_RS1_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
           OpCode_RS2_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
           OpCode_RS3_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
			  
	 	   ID_RS1_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
		   ID_RS2_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
		   ID_RS3_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
			  
  		   Qk_RS1_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
           Qk_RS2_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
           Qk_RS3_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
		   Qj_RS1_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
           Qj_RS2_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
           Qj_RS3_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
			  
		   Vk_RS1_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0);
           Vk_RS2_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0);
           Vk_RS3_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0);
		   Vj_RS1_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS2_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS3_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0));
end component;

component FU_Arithmetic 
    Port ( CLK        : in  STD_LOGIC;
           EN       : in  STD_LOGIC;
		   OP       : in  STD_LOGIC_VECTOR (1 downto 0);
           Vk       : in  STD_LOGIC_VECTOR (31 downto 0);
           Vj       : in  STD_LOGIC_VECTOR (31 downto 0);
		   Tag_IN     : in  STD_LOGIC_VECTOR (4 downto 0);
           Grand    : in  STD_LOGIC;
			 
		   full_out : out  STD_LOGIC;  
           Result_A : out  STD_LOGIC_VECTOR (31 downto 0);
           Tag_1  : out  STD_LOGIC_VECTOR (4 downto 0);
           Tag_2  : out  STD_LOGIC_VECTOR (4 downto 0);
           Tag_OUT  : out  STD_LOGIC_VECTOR (4 downto 0);
           Poke_A   : out  STD_LOGIC);
end component;
SIGNAL  OPCODE_RS1_IN_TMP,OPCODE_RS2_IN_TMP,OPCODE_RS3_IN_TMP,Qk_RS1_IN_TMP,Qk_RS2_IN_TMP,Qk_RS3_IN_TMP,QJ_RS1_IN_TMP,QJ_RS2_IN_TMP,QJ_RS3_IN_TMP :  std_logic_vector(4 downto 0);
SIGNAL  ID_RS1_OUT_TMP,ID_RS2_OUT_TMP,ID_RS3_OUT_TMP,CDB_Q_TMP,qk_tmp,qj_tmp,TAG_A_tmp : std_logic_vector(4 downto 0);
SIGNAL  Qj_RS1_OUT_TMP,Qj_RS2_OUT_TMP,Qj_RS3_OUT_TMP,Qk_RS1_OUT_TMP,Qk_RS2_OUT_TMP,Qk_RS3_OUT_TMP,Tag_in_TMP,opcode_tmp,tag_1_tmp,tag_2_tmp : std_logic_vector(4 downto 0);
SIGNAL  Vk_RS1_IN_TMP,Vk_RS2_IN_TMP,Vk_RS3_IN_TMP,Vj_RS1_IN_TMP,Vj_RS2_IN_TMP,Vj_RS3_IN_TMP, CDB_V_TMP,vk_tmp,vj_tmp : std_logic_vector(31 downto 0);
SIGNAL  Vk_RS1_OUT_TMP,Vk_RS2_OUT_TMP,Vk_RS3_OUT_TMP, VJ_RS1_OUT_TMP, VJ_RS2_OUT_TMP, VJ_RS3_OUT_TMP,Vk_FU_TMP,Vj_FU_TMP : std_logic_vector(31 downto 0);
SIGNAL  EN_RS1_TMP,EN_RS2_TMP,EN_RS3_TMP,RB_TMP  : std_logic_vector(2 downto 0);
SignaL  En_fu_tmp,Grand_tmp,Poke_A_tmp,full_fu_tmp: std_logic;
SignaL  OpCode_RS1_OUT_TMP,OpCode_RS2_OUT_TMP,OpCode_RS3_OUT_TMP: std_logic_vector(4 downto 0);
signal op_tmp : std_logic_vector(1 downto 0);
signal free_out_tmp_s : std_logic_vector(2 downto 0);

begin

FU_A : FU_Arithmetic
Port Map(CLK     =>CLK ,   
         EN      => En_FU_tmp,
         OP      => Op_tmp,    
         Vk      => Vk_FU_TMP,    
         Vj      => VJ_FU_TMP,
         Tag_in  => Tag_in_TMP,    
         Grand   => Grand_in_A, 
         full_out=> full_fu_tmp,
         Result_A=> Res_A,
         tag_1   => tag_1_tmp, 
         tag_2   => tag_2_tmp, 
         Tag_OUT => TAG_A_tmp,
         Poke_A  => Poke_out_A);





RS_A: RS_Arithmetic
Port Map(  CLK       => CLK ,       
           EN_RS1    => EN_RS1_TMP ,  
		   EN_RS2    => EN_RS2_TMP ,    
		   EN_RS3    => EN_RS3_TMP,    
		  -- Free_in   => FREE_IN_TMP,      
		    	 
           OpCode_RS1_IN  => OPCODE_RS1_IN_TMP,  
           OpCode_RS2_IN  => OPCODE_RS2_IN_TMP,  
           OpCode_RS3_IN  => OPCODE_RS3_IN_TMP,  
           		 
		   Qk_RS1_IN   =>  Qk_RS1_IN_TMP,      
           Qk_RS2_IN   =>  Qk_RS2_IN_TMP, 
           Qk_RS3_IN   =>  Qk_RS3_IN_TMP,      
	       Qj_RS1_IN   =>  QJ_RS1_IN_TMP,      
           Qj_RS2_IN   =>  QJ_RS2_IN_TMP,      
           Qj_RS3_IN   =>  QJ_RS3_IN_TMP,  
			
		   Vk_RS1_IN   =>Vk_RS1_IN_TMP,  
           Vk_RS2_IN   => Vk_RS2_IN_TMP ,  
           Vk_RS3_IN   => Vk_RS3_IN_TMP  ,  
		   Vj_RS1_IN   =>  Vj_RS1_IN_TMP ,  
           Vj_RS2_IN   => Vj_RS2_IN_TMP  ,  
           Vj_RS3_IN   => Vj_RS3_IN_TMP  ,  
			ID_ROB_RS  =>ID_ROB_RS, 
			 
			 
		   Rb         => RB_TMP , 
		   --Free_out   => FREE_OUT_TMP , 
 	 
		   OpCode_RS1_OUT=>   OpCode_RS1_OUT_TMP, 
           OpCode_RS2_OUT=>   OpCode_RS2_OUT_TMP, 
           OpCode_RS3_OUT=>   OpCode_RS3_OUT_TMP, 
			
	 	   ID_RS1_OUT => ID_RS1_OUT_TMP , 
		   ID_RS2_OUT => ID_RS2_OUT_TMP , 
		   ID_RS3_OUT => ID_RS3_OUT_TMP , 
			
  		   Qk_RS1_OUT =>  Qk_RS1_OUT_TMP , 
           Qk_RS2_OUT =>  Qk_RS2_OUT_TMP , 
           Qk_RS3_OUT =>  Qk_RS3_OUT_TMP , 
		   Qj_RS1_OUT =>  Qj_RS1_OUT_TMP , 
           Qj_RS2_OUT =>  Qj_RS2_OUT_TMP , 
           Qj_RS3_OUT =>  Qj_RS3_OUT_TMP , 
			
		   Vk_RS1_OUT =>  Vk_RS1_OUT_TMP, 
           Vk_RS2_OUT =>  Vk_RS2_OUT_TMP , 
           Vk_RS3_OUT =>  Vk_RS3_OUT_TMP , 
		   Vj_RS1_OUT =>  VJ_RS1_OUT_TMP , 
           Vj_RS2_OUT =>  Vj_RS2_OUT_TMP , 
           Vj_RS3_OUT =>  Vj_RS3_OUT_TMP );

Tag_a <= TAG_A_tmp;
CDB_Q_TMP <= CDB_Q;
CDB_V_TMP <= CDB_V;
Vk_tmp    <= Vk;
Vj_tmp    <= Vj;
Qk_tmp    <= Qk;
Qj_tmp    <= Qj;
opcode_tmp<= opcode;
---------------------------------------shmatadh waihifld

microcontroller : process(clk,full_fu_tmp,rb_tmp,cdb_q,stop,opcode,Vk,Vj,Qk,Qj)
variable free_out_tmp : std_logic_vector(2 downto 0);
begin



if rising_edge(clk) then 

free_out_tmp(2) := opcode_rs1_out_tmp(4);
free_out_tmp(1) := opcode_rs2_out_tmp(4);
free_out_tmp(0) := opcode_rs3_out_tmp(4);
else null;
end if; 
-------------------------------------------------------------------
----------DROMOLOGISH EISODWN THS FU
-------------------------------------------------------------------
IF ((rb_tmp(2)='1')and(tag_1_tmp/=ID_RS1_OUT_TMP)and(tag_2_tmp/=ID_RS1_OUT_TMP)and(TAG_A_tmp/=ID_RS1_OUT_TMP)and(opcode_rs1_out_tmp(4)='0')) THEN --tote RS1 etoimo gia na mpei sthn ALU,an den uparxei idi mesa ena tetoio ID/Tag, kai 1 prwto bit mas leei oti einai se xrhsh sto sugkekrimeno RS slot
    if(full_fu_tmp='0') then --simainei oti sto epomeno clock tha exei mpei sthn FU
        EN_FU_TMP<='1'; 
        TAG_IN_TMP<=ID_RS1_OUT_TMP;
        --free_out_tmp(2):='1';   --  molis bgei apo fu tha to eleutherwsoume(updated)
    ELSE 
        EN_FU_TMP<='0'; 
        TAG_IN_TMP<="11111";
    END IF;
    Vk_FU_TMP <=  Vk_RS1_OUT_TMP;
    Vj_FU_TMP <=  Vj_RS1_OUT_TMP;
    Op_tmp    <= OpCode_RS1_OUT_TMP(1 downto 0);
elsIF ((rb_tmp(1)='1')and(tag_1_tmp/=ID_RS2_OUT_TMP)and(tag_2_tmp/=ID_RS2_OUT_TMP)and(TAG_A_tmp/=ID_RS2_OUT_TMP)and(opcode_rs2_out_tmp(4)='0')) THEN
    if(full_fu_tmp='0') then 
        EN_FU_TMP<='1'; 
        TAG_IN_TMP<=ID_RS2_OUT_TMP;
        --free_out_tmp(1):='1';
    ELSE 
        EN_FU_TMP<='0'; 
        TAG_IN_TMP<="11111";
    END IF; 
    Vk_FU_TMP <= Vk_RS2_OUT_TMP ;
    Vj_FU_TMP <= Vj_RS2_OUT_TMP ; 
    Op_tmp    <= OpCode_RS2_OUT_TMP(1 downto 0);
elsIF ((rb_tmp(0)='1')and(tag_1_tmp/=ID_RS3_OUT_TMP)and(tag_2_tmp/=ID_RS3_OUT_TMP)and(TAG_A_tmp/=ID_RS3_OUT_TMP)and(opcode_rs3_out_tmp(4)='0')) THEN 
    if(full_fu_tmp='0') then 
        EN_FU_TMP<='1'; 
        TAG_IN_TMP<=ID_RS3_OUT_TMP;
        --free_out_tmp(0):='1';
    ELSE 
        EN_FU_TMP<='0'; 
        TAG_IN_TMP<="11111";
    END IF;
    Vk_FU_TMP <=  Vk_RS3_OUT_TMP;
    Vj_FU_TMP <= Vj_RS3_OUT_TMP ;
    Op_tmp    <= OpCode_RS3_OUT_TMP(1 downto 0);
else                                              ----------Periptwsh pou den exoume plhroforia, tag=11111 ,diladi tipota
    if(full_fu_tmp='0') then
        EN_FU_TMP<='1'; 
        TAG_IN_TMP<="11111";
    ELSE
        EN_FU_TMP<='0'; 
        TAG_IN_TMP<="11111";
    end if;
END IF;

---------------------------------------------
-- elexgos gia to pote h entolh bgike apo fu, wste na eleutherwthei
---------------------------------------------
IF((ID_RS1_OUT_TMP = CDB_Q_TMP)and(ID_RS1_OUT_TMP(3)='1')) THEN 
    free_out_tmp(2):='1';
elsif ((ID_RS2_OUT_TMP = CDB_Q_TMP)and(ID_RS2_OUT_TMP(3)='1')) then
    free_out_tmp(1):='1';
elsif ((ID_RS3_OUT_TMP = CDB_Q_TMP)and(ID_RS3_OUT_TMP(3)='1')) then
    free_out_tmp(0):='1';
else
    null;
end if;


  


---------------------------------------------
---enhmerwsh ths katastashs(gia na 3eroume KAI sto epomeno kuklo, sumfwna me to ti uphrxe kai ti alla3e twra.oxi twra....TWRA!)
---------------------------------------------
     
IF((opcode_rs1_out_tmp(4)='0')and(free_out_tmp(2)='1')) then 
    opcode_rs1_in_tmp(4)<='1';
    en_rs1_tmp(2)<='1';
    en_rs1_tmp(1)<='0';
    en_rs1_tmp(0)<='0';
else
    en_rs1_tmp(2)<='0';
end if;
IF((opcode_rs2_out_tmp(4)='0')and(free_out_tmp(1)='1')) then 
    opcode_rs2_in_tmp(4)<='1';
    en_rs2_tmp(2)<='1';
    en_rs2_tmp(1)<='0';
    en_rs2_tmp(0)<='0';
else
    en_rs2_tmp(2)<='0';
end if;
IF((opcode_rs3_out_tmp(4)='0')and(free_out_tmp(0)='1')) then 
    opcode_rs3_in_tmp(4)<='1';
    en_rs3_tmp(2)<='1';
    en_rs3_tmp(1)<='0';
    en_rs3_tmp(0)<='0';
else
    en_rs3_tmp(2)<='0';
end if;     
       
     
     
     
 
------------------------------------------------------------
-- Eisodos RS
--dromologish opcode,Vk,Vj,Qk,Qj kai EN ths monadas, apo Issue(pou tha exei perasei mesa apo main microcontroller)
------------------------------------------------------------

--IF((free_out_tmp(2)/='0')and Qk_rs1_out_tmp="11111" and Qj_rs1_out_tmp="11111")or (((free_out_tmp(2)/='0')and (Qk_rs1_out_tmp="11111" and Qj_rs1_out_tmp="11111")) then--einai h prokeitai na einai eleutheros h 1h RS 


if(stop='1') then 
    en_rs1_tmp<="000";
    en_rs2_tmp<="000";
    en_rs3_tmp<="000";
    IF((opcode_rs1_in_tmp(4)='0')and(free_out_tmp(2)='1')) then 
        opcode_rs1_in_tmp(4)<='1';
        en_rs1_tmp(2)<='1';
        en_rs1_tmp(1)<='0';
        en_rs1_tmp(0)<='0';
    else
        en_rs1_tmp(2)<='0';
    end if;
    IF((opcode_rs2_in_tmp(4)='0')and(free_out_tmp(1)='1')) then 
        opcode_rs2_in_tmp(4)<='1';
        en_rs2_tmp(2)<='1';
        en_rs2_tmp(1)<='0';
        en_rs2_tmp(0)<='0';
    else
        en_rs2_tmp(2)<='0';
    end if;
    IF((opcode_rs3_in_tmp(4)='0')and(free_out_tmp(0)='1')) then 
        opcode_rs3_in_tmp(4)<='1';
        en_rs3_tmp(2)<='1';
        en_rs3_tmp(1)<='0';
        en_rs3_tmp(0)<='0';
    else
        en_rs3_tmp(2)<='0';
    end if;     
           
elsif (((free_out_tmp(2)/='0') or (opcode_rs1_out_tmp(4)/='0')) and (Qk_tmp="00100" or Qk_tmp="00101" or Qk_tmp="01001" or Qk_tmp="01010" or Qk_tmp="01011" or Qk_tmp="11111")
                                                             and (Qk_tmp="00100" or Qk_tmp="00101" or Qj_tmp="01001" or Qj_tmp="01010" or Qj_tmp="01011" or Qj_tmp="11111") ) then   
    free_out_tmp(2)      :='0'; --to akurwnw edw,
    opcode_rs1_in_tmp(4)<='0'; 
    vk_rs1_in_tmp  <= vk_tmp;
    vj_rs1_in_tmp <= vj_tmp;
    qk_rs1_in_tmp <= qk_tmp;
    qj_rs1_in_tmp <= qj_tmp;
    OPCODE_RS1_IN_TMP<=opcode_tmp;
    ID_A_OUT <= id_rs1_out_tmp;
    --ID_ROB_RS
    en_rs1_tmp<="111";
    en_rs2_tmp<="000";
    en_rs3_tmp<="000";

elsif (((free_out_tmp(1)/='0')or (opcode_rs2_out_tmp(4)/='0')) and (Qk_tmp="00100" or Qk_tmp="00101" or Qk_tmp="01001" or Qk_tmp="01010" or Qk_tmp="01011" or Qk_tmp="11111")
                                                              and (Qk_tmp="00100" or Qk_tmp="00101" or Qj_tmp="01001" or Qj_tmp="01010" or Qj_tmp="01011" or Qj_tmp="11111") ) then   
    free_out_tmp(1)      :='0'; --to akurwnw edw,
    opcode_rs2_in_tmp(4)<='0'; 
    vk_rs2_in_tmp  <= vk_tmp;
    vj_rs2_in_tmp <= vj_tmp;
    qk_rs2_in_tmp <= qk_tmp;
    qj_rs2_in_tmp <= qj_tmp;
    OPCODE_RS2_IN_TMP<=opcode_tmp;
    ID_A_OUT <= id_rs2_out_tmp;
    en_rs1_tmp<="000";
    en_rs2_tmp<="111";
    en_rs3_tmp<="000";

 elsif (((free_out_tmp(0)/='0')or (opcode_rs3_out_tmp(4)/='0')) and (Qk_tmp="00100" or Qk_tmp="00101" or Qk_tmp="01001" or Qk_tmp="01010" or Qk_tmp="01011" or Qk_tmp="11111")
                                                               and (Qk_tmp="00100" or Qk_tmp="00101" or Qj_tmp="01001" or Qj_tmp="01010" or Qj_tmp="01011" or Qj_tmp="11111") ) then 
    free_out_tmp(0)      :='0'; --to akurwnw edw,
    opcode_rs3_in_tmp(4)<='0'; 
    vk_rs3_in_tmp  <= vk_tmp;
    vj_rs3_in_tmp <= vj_tmp;
    qk_rs3_in_tmp <= qk_tmp;
    qj_rs3_in_tmp <= qj_tmp;
    OPCODE_RS3_IN_TMP<=opcode_tmp;
    ID_A_OUT <= id_rs3_out_tmp;
    en_rs1_tmp<="000";
    en_rs2_tmp<="000";
    en_rs3_tmp<="111";
    if ((opcode_rs1_out_tmp(4)='1')or(opcode_rs2_out_tmp(4)='1')or(opcode_rs3_out_tmp(4)='1')or(free_out_tmp(2)/='0')or(free_out_tmp(1)/='0')or(free_out_tmp(0)/='0'))  then 
        free_a<='1';
    else 
        free_a<='0';
    end if;
else 
    en_rs1_tmp(1 downto 0)<="00";
    en_rs2_tmp(1 downto 0)<="00";
    en_rs3_tmp(1 downto 0)<="00";

end if;



---------------------------------------------------------------
--Forwarding, CDB --> RS
---------------------------------------------------------------

if (CDB_Q_TMP="00100" or CDB_Q_TMP="00101" or CDB_Q_TMP="01001" or CDB_Q_TMP="01010" or CDB_Q_TMP="01011") THEN
--IF(CDB_Q_TMP = "01001" or CDB_Q_TMP = "01010" or CDB_Q_TMP = "01011") THEN          
    IF(Qk_rs1_out_tmp = CDB_Q_TMP) THEN  --may need free bit also
        EN_RS1_TMP(1)    <= '1';
        Vk_RS1_IN_TMP <= CDB_V_TMP;      
        QK_RS1_IN_TMP <= "11111";
    else null;
    end if;
    if (Qj_rs1_out_tmp = CDB_Q_TMP) THEN
        EN_RS1_TMP(0)    <= '1';
        Vj_RS1_IN_TMP <= CDB_V_TMP;      
        Qj_RS1_IN_TMP <= "11111";
    else null;
    end if;
    if (Qk_rs2_out_tmp = CDB_Q_TMP) THEN
        EN_RS2_TMP(1)    <= '1';
        Vk_RS2_IN_TMP <= CDB_V_TMP;      
        Qk_RS2_IN_TMP <= "11111";
    else null;
    end if;
    if (Qj_rs2_out_tmp = CDB_Q_TMP) THEN
        EN_RS2_TMP(0)    <= '1';
        Vj_RS2_IN_TMP <= CDB_V_TMP;      
        Qj_RS2_IN_TMP <= "11111";
    else null;
    end if;
    IF (Qk_rs3_out_tmp = CDB_Q_TMP) THEN
        EN_RS3_TMP(1)    <= '1';
        Vk_RS3_IN_TMP <= CDB_V_TMP;      
        QK_RS3_IN_TMP <= "11111";
    else null;
    end if;
    if (Qj_rs3_out_tmp = CDB_Q_TMP) THEN
        EN_RS3_TMP(0)    <= '1';
        Vj_RS3_IN_TMP <= CDB_V_TMP;      
        Qj_RS3_IN_TMP <= "11111";
    else null;
    end if;
else null;
end if;

 --------------------------------------------------------
 --eisodos RS
 --   periptwsh pou, h kainourgia entolh THA perimenei ena Qk, alla EKEINH thn stigmh to exei bgalei o cdb 
 --------------------------------------------------------
--RS1
if((qk_rs1_in_tmp = CDB_Q_TMP)and(CDB_Q_TMP/="11111")and(en_rs1_tmp="111"))  then 
    Vk_RS1_IN_TMP <= CDB_V_TMP;      
    Qk_RS1_IN_TMP <= "11111";
 else null;
 end if;
 if ((qj_rs1_in_tmp = CDB_Q_TMP)and(CDB_Q_TMP/="11111")and(en_rs1_tmp="111"))  then 
        Vj_RS1_IN_TMP <= CDB_V_TMP;      
        Qj_RS1_IN_TMP <= "11111"; 
else null;
end if;

--RS2
if((qk_rs2_in_tmp = CDB_Q_TMP)and(CDB_Q_TMP/="11111")and(en_rs2_tmp="111"))  then 
    Vk_RS2_IN_TMP <= CDB_V_TMP;      
    Qk_RS2_IN_TMP <= "11111";
 else null;
 end if;
 if ((qj_rs2_in_tmp = CDB_Q_TMP)and(CDB_Q_TMP/="11111")and(en_rs2_tmp="111"))  then 
     Vj_RS2_IN_TMP <= CDB_V_TMP;      
     Qj_RS2_IN_TMP <= "11111"; 
else null;
end if;

--RS3
if((qk_rs3_in_tmp = CDB_Q_TMP)and(CDB_Q_TMP/="11111")and(en_rs3_tmp="111"))  then 
    Vk_RS3_IN_TMP <= CDB_V_TMP;      
    Qk_RS3_IN_TMP <= "11111";
 else null;
 end if;
 if((qj_rs3_in_tmp = CDB_Q_TMP)and(CDB_Q_TMP/="11111")and(en_rs3_tmp="111"))  then 
     Vj_RS3_IN_TMP <= CDB_V_TMP;      
     Qj_RS3_IN_TMP <= "11111"; 
else null;
end if;

----------------------------------------------------------
-----elegxos gia th RS , ama exei keno xwro
----------------------------------------------------------
--(opcode_rs1_out_tmp(4)='1')or(opcode_rs2_out_tmp(4)='1')or(opcode_rs3_out_tmp(4)='1')
if ((free_out_tmp(2)/='0')or(free_out_tmp(1)/='0')or(free_out_tmp(0)/='0'))  then 
    free_a<='1';
else 
    free_a<='0';
end if;




end process;



end Behavioral;
