----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2018 10:59:09 AM
-- Design Name: 
-- Module Name: MC - Behavioral
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

entity MC is
    Port ( CLK : in STD_LOGIC;
           OpCode : in STD_LOGIC_VECTOR (4 downto 0);
           Vk : in STD_LOGIC_VECTOR (31 downto 0);
           Qk : in STD_LOGIC_VECTOR (4 downto 0);
           Vj : in STD_LOGIC_VECTOR (31 downto 0);
           Qj : in STD_LOGIC_VECTOR (4 downto 0);
           CDB_V_IN : in STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q_IN : in STD_LOGIC_VECTOR (4 downto 0);
           Grand_in_A :in STD_LOGIC;
           Grand_in_L :in STD_LOGIC;
           Fu_type   : in STD_LOGIC_VECTOR (1 downto 0);
           Stop_In          : in STD_LOGIC;
           rob_vk :in STD_LOGIC_VECTOR (31 downto 0);
           rob_vj : in STD_LOGIC_VECTOR (31 downto 0);
           rob_qk : in STD_LOGIC_VECTOR (4 downto 0);
           rob_qj : in STD_LOGIC_VECTOR (4 downto 0);
           rob_id  : in STD_LOGIC_VECTOR (4 downto 0);
           rob_dest: in STD_LOGIC_VECTOR (4 downto 0);
           rob_status: in STD_LOGIC;
           cdb_v: in STD_LOGIC_VECTOR (31 downto 0);
           cdb_q : in STD_LOGIC_VECTOR (4 downto 0);
           rob_value: in STD_LOGIC_VECTOR (31 downto 0);
           
           
           rob_en :out STD_LOGIC;
           rf_dest_out: out std_logic_vector(4 downto 0); --pros rf
           rf_val_out : out STD_LOGIC_VECTOR (31 downto 0);  --pros rf         
           ID_out : out std_logic_vector(4 downto 0);
           Poke_out_A :out STD_LOGIC;
           Poke_out_L :out STD_LOGIC;           
           Result : out STD_LOGIC_VECTOR (31 downto 0);
           Tag_out : out STD_LOGIC_VECTOR (4 downto 0);
           Free_a_out : out STD_LOGIC;
           Free_l_out : out STD_LOGIC);
end MC;

architecture Behavioral of MC is
SIGNAL Vk_tmp, Vj_tmp,CDB_V_tmp,result_a_tmp,result_L_tmp : STD_LOGIC_vector(31 downto 0);  
SIGNAL Qk_tmp,Qj_tmp,CDB_Q_TMP,Opcode_A_tmp,id_a_out_tmp,Tag_A_tmp,Opcode_L_tmp,id_L_out_tmp,Tag_L_tmp,ID_ROB_RS_TMP : STD_LOGIC_vector(4 downto 0);       
SIGNAL Poke_out_A_tmp,grand_in_A_tmp,Poke_out_L_tmp,grand_in_L_TMP,free_A_tmp,free_L_tmp,stop_l_tmp,stop_a_tmp : STD_LOGIC; 
        

Component MC_RS_FU_A  
Port (     clk       : in STD_LOGIC;
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
           Free_A    : out STD_LOGIC);                         --THA EINAI UPEUTHUNO GIA THN ENERGOPOIHSH THS ROHS TWN NEWN ENTOLVN KAI TOU EN THS RS
end component;

Component MC_RS_FU_L 
    Port ( clk        : in STD_LOGIC;
           Grand_in_L: in STD_LOGIC;
           Vk        : in STD_LOGIC_VECTOR (31 downto 0);  --APO ISSUE
           Vj        : in STD_LOGIC_VECTOR (31 downto 0);  --APO ISSUE
           Qk        : in STD_LOGIC_VECTOR (4 downto 0);  --APO ISSUE. THA EXEI PAREI TIMH EGJURH,AN VK,VJ DEN EXOUN TIMES KAI TIS ANAMENOUN APO KAPOIO ID
           Qj        : in STD_LOGIC_VECTOR (4 downto 0);  --APO ISSUE
           CDB_V     : in STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q     : in STD_LOGIC_VECTOR (4 downto 0);
           OpCode    : in STD_LOGIC_VECTOR (4 downto 0); --apo issue, me 5o bit nanai panta '0' (busy)
           Stop          : in STD_LOGIC;
      
      
           Poke_out_L: out STD_LOGIC;
           Res_L     : out STD_LOGIC_VECTOR (31 downto 0);
           ID_L_OUT  : out STD_LOGIC_VECTOR (4 downto 0);   --POU THA TO BLEPEI TO ISSUE GIA NA TO BALEI STON ANTISTOIXO REG POU PERIMENEI APOTELESMA
           Tag_L     : out STD_LOGIC_VECTOR (4 downto 0);       -- GIA THN FU
           Free_L    : out STD_LOGIC);                         --THA EINAI UPEUTHUNO GIA THN ENERGOPOIHSH THS ROHS TWN NEWN ENTOLVN KAI TOU EN THS RS
end component;

begin
MC_RS_FU_A_Unit : MC_RS_FU_A
Port Map(clk       =>clk,
         Grand_in_A=>grand_in_A,
         Vk        =>Vk_tmp,
         Vj        =>Vj_tmp,
         Qk        =>Qk_tmp,
         Qj        =>Qj_tmp,
         CDB_V     =>CDB_V_IN,--PROWTHISI TIMWS CDB_V,CDB_Q KAI STIS 2 RESERVATION MONADES,xwris kanena elegxo h e3arthsh, oi upo-MC tha antikatasthsoun oti broun aparaithto
         CDB_Q     =>CDB_Q_IN,
         OpCode    =>Opcode_A_tmp,
         stop      =>stop_a_tmp,   
         ID_ROB_RS =>ID_ROB_RS_TMP,
                   
         Poke_out_A=>Poke_out_A,
         Res_A     =>result_a_tmp,
         ID_A_OUT  =>id_a_out_tmp,         
         Tag_A     =>Tag_A_tmp,
         Free_A    =>free_A_tmp); 

MC_RS_FU_L_Unit : MC_RS_FU_L
Port Map(clk       =>clk,
         Grand_in_L=>grand_in_L,
         Vk        =>Vk_tmp,
         Vj        =>Vj_tmp,
         Qk        =>Qk_tmp,
         Qj        =>Qj_tmp,
         CDB_V     =>CDB_V_IN,--PROWTHISI TIMWS CDB_V,CDB_Q KAI STIS 2 RESERVATION MONADES,xwris kanena elegxo h e3arthsh, oi upo-MC tha antikatasthsoun oti broun aparaithto
         CDB_Q     =>CDB_Q_IN,
         OpCode    =>Opcode_L_tmp,
         stop      =>stop_l_tmp, 
                   
         Poke_out_L=>Poke_out_L,
         Res_L     =>result_L_tmp,
         ID_L_OUT  =>id_L_out_tmp,         
         Tag_L     =>Tag_L_tmp,
         Free_L    =>free_L_tmp); 


microcontroller : process(fu_type,rob_dest,id_a_out_tmp,tag_l_tmp,tag_a_tmp,clk,free_L_tmp,Free_A_tmp,result_a_tmp,result_L_tmp,opcode,id_l_out_tmp,Vk,Vj,Qk,Qj,grand_in_a,grand_in_l,stop_in)
begin


if(stop_in='0') then 
    if(opcode(3 downto 2)="00") then  --an logikh pra3h en opsh
        stop_a_tmp<='1';
    else
        stop_a_tmp<='0';
    end if;
    if(opcode(3 downto 2)="01") then  --an arithmitikh pra3h en opsh
        stop_l_tmp<='1';
    else
        stop_l_tmp<='0';
    end if;
else
    stop_a_tmp<='1';
    stop_l_tmp<='1';
end if;



--------
--spasimo arxikh periptwshs(+exception)
--------
if((Opcode(3 downto 2) /= "01" )and (Opcode(3 downto 2) /= "00" )) then 
    free_a_out<='1';
    free_l_out<='1';
end if;


----------------------------------------
--DROMOLOGISH apo issue se RS, ama den einai diathesimo to RS pou theloume tote pagwnoume to issue gia na mhn xasoume entolez
----------------------------------------
--------------------------------------------------test test test
if((free_A_tmp='1')and((Opcode(3 downto 2)="01")or(fu_type="01"))) Then
    free_a_out <= '1';
end if;

if((free_l_tmp='1')and((Opcode(3 downto 2)="00")or(fu_type="00"))) Then
    free_l_out <= '1';
end if;

---epishs mia logikh pou tha apofasizei ti value tha dwsei sthn RF, tou ROB h tou cdb(ROB OTAN rob1 einai ready opote mallon o cdb exei value gia kapio allo rob#, h cdb_v otan rob1 not ready kai cdb_q = rob_r_dest )
--rob_dest,rob_value pernoun apodw
if((rob_dest = cdb_q)) then  -- perpitwsh pou rob1_dest = cdb_q (dil. rob1 not ready alla molis exei bgei to apotelesma ston cdb)
    rf_dest_out <= rob_dest; --(h cdb_q, einai to idio)
    rf_val_out   <= cdb_v;
elsif(rob_status = '1') then --ready to rob1, ara bazoume to value tou sthn rf gia egraffh
    rf_dest_out <= rob_dest;
    rf_val_out   <= rob_value;
elsif(rob_status = '0') then 
    rf_dest_out<= "00000";    --gia na mhn grapsei tpt, perimenoume
else null;
end if;
    



if((Opcode(3 downto 2) = "01")and(stop_in='0')) then --an h entolh einai tupou arithmetic
   -- ID_out<=ID_a_OUT_TMP;
    if(free_A_tmp='1') Then        --des an einai diathesimh h Arithmetic Unit
    
    
    ------------------------------------- TIS PARAKATW TIMES THA TIS PAREI EITE APO ROB EITE APO RF(SHMEIWSH MANOU)
    if(rob_qk ="11110") then --EKMETALEUOMASTE THN DESMEUMENH TIMH GIA NA DEI3OUME OTI TO STOIXEIO DEN UPARXEI MESA STON ROB(epilegoume), to 11111 deixnei oti uparxei ston ROB kai oriste h timh tou(den epilegoume rf)
        Vk_tmp <= Vk; --pare thn timh apo rf
        Qk_tmp <= "11111"; -- olo asous mesa sto rs. gt thn exoume thn timh
     elsif(rob_qk ="11111") then -- auto shmainei pws uparxei h timh sto ROB kai einai etoimh, DEN epilgeoume rf
        Vk_tmp<=rob_vk;
        Qk_tmp <= rob_qk; --11111
     else                   ---periptwsh pou uparxei ston ROB alla den einai diathesimh h timh  (Qk=rob# apopou perimenoume)
        Qk_tmp <= rob_qk;
     end if;
 
     if(rob_qj ="11110") then --EKMETALEUOMASTE THN DESMEUMENH TIMH GIA NA DEI3OUME OTI TO STOIXEIO DEN UPARXEI MESA STON ROB(epilegoume), to 11111 deixnei oti uparxei ston ROB kai oriste h timh tou(den epilegoume rf)
        Vj_tmp <= Vj; --pare thn timh apo rf
        Qj_tmp <= "11111"; -- olo asous mesa sto rs. gt thn exoume thn timh
     elsif(rob_qj ="11111") then -- auto shmainei pws uparxei h timh sto ROB kai einai etoimh, DEN epilgeoume rf
        Vj_tmp<=rob_vj;
        Qj_tmp <= rob_qj; --11111
     else                   ---periptwsh pou uparxei ston ROB alla den einai diathesimh h timh  (Qj=rob# apopou perimenoume)
        Qj_tmp <= rob_qj;
     end if;
     
     
      -------------------------
        opcode_A_tmp <= opcode;
        
        free_a_out <= '1';      --gemisei me auto pou bazw twra, tha enhmerwthei auth h metablith asugxrona me to pou apanthsei (se ayton to kuklo to RS)
       ------------ENABLE TOU ROB KAI NEO RS_ID(TOP_ROB_ID APO ROB)
        ID_ROB_rs_TMP<=ROB_ID;--touto, pagainei sto shmeio pou energopoiheitai to prwto diathesimo slot tou RS gia na bgei sthn e3odo tou(RS#_ID)
        rob_en<='1';
       ----------------
        stop_l_tmp<='1';   -- wste na stamathsei na roufaei pragmata pou blepei sthn eisodo tou(logiko RS)
        stop_a_tmp<='0';
       
    else
        ------------DISABLE TOU ROB 
        rob_en<='0';  
        ----------------
        free_a_out <= '0';
    end if; 
elsif((Opcode(3 downto 2) = "00")AND(stop_in='0')) then --an h entolh einai tupou Logical
   -- ID_out<=ID_L_OUT_TMP;
    if(free_L_tmp='1') Then        --des an einai diathesimh h Logical Unit
        
        
        if(rob_qk ="11110") then 
            Vk_tmp <= Vk; 
            Qk_tmp <= "11111"; 
         elsif(rob_qk ="11111") then
            Vk_tmp<=rob_vk;         
            Qk_tmp <= rob_qk; 
         else                  
            Qk_tmp <= rob_qk;       
         end if;                    
                                    
         if(rob_qj ="11110") then 
            Vj_tmp <= Vj; 
            Qj_tmp <= "11111"; 
         elsif(rob_qj ="11111") then
            Vj_tmp<=rob_vj;         
            Qj_tmp <= rob_qj; 
         else                  
            Qj_tmp <= rob_qj;       
         end if;                    
        
        opcode_L_tmp <= opcode;
        free_l_out <= '1';
        stop_a_tmp<='1';   -- wste na stamathsei na roufaei pragmata pou blepei sthn eisodo tou
        stop_l_tmp<='0';
        --
        ID_ROB_rs_TMP<=ROB_ID;--touto, pagainei sto shmeio pou energopoiheitai to prwto diathesimo slot tou RS gia na bgei sthn e3odo tou(RS#_ID)
        rob_en<='1';
        --
    else
        free_l_out <= '0';
        
        rob_en<='0'; ----------DISABLE TOU ROB   (prosoxh na dw ton sugxronismo!!!)   
    end if;
else null;
end if;


----------------------------------------
----------------------------------------
--dromologish e3odou Result
----------------------------------------
if(grand_in_a = '1') then   
    result <= result_A_tmp;
    tag_out<= tag_A_tmp;
elsif (grand_in_L = '1')  then 
    result <= result_L_tmp;
    tag_out<= tag_L_tmp;
else
    tag_out<="11111"; 
end if;


end process;

end Behavioral;
