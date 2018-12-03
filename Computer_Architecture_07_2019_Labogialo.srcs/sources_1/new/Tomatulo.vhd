----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2018 08:22:22 PM
-- Design Name: 
-- Module Name: Tomatulo - Behavioral
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

entity Tomatulo is
    Port ( CLK : in STD_LOGIC;
           Accepted:  out STD_LOGIC; 
            
           reset : in STD_LOGIC;    
           Fu_type   : in STD_LOGIC_VECTOR (1 downto 0);
           FOp       : in STD_LOGIC_VECTOR (1 downto 0);
           R_dest    : in STD_LOGIC_VECTOR (4 downto 0);
           Rk_addr   : in STD_LOGIC_VECTOR (4 downto 0);
           Rj_addr   : in STD_LOGIC_VECTOR (4 downto 0); 
           Issue_in     : in STD_LOGIC);
           
           
end Tomatulo;

architecture Behavioral of Tomatulo is

SIGNAL  MC_Res_tmp, CDB_V_tmp,rk_v_tmp, rj_v_tmp  :STD_LOGIC_VECTOR (31 downto 0);
SIGNAL  Rj_addr_tmp,rs_id_tmp,QK_OUT_tmp,Qj_OUT_tmp,opcode_tmp  : STD_LOGIC_VECTOR (4 downto 0);
signal   MC_tag_tmp,CDB_Q_tmp,R_dest_tmp,Rk_addr_tmp : STD_LOGIC_VECTOR (4 downto 0);
         
SIGNAL  poke_tmp, grand_tmp  : STD_LOGIC_VECTOR (1 downto 0);
signal rst_tmp,free_out_tmp,stop_tmp,free_a_out_tmp,free_l_out_tmp : std_logic;

  

component MC is
    Port ( CLK          : in STD_LOGIC;
           OpCode       : in STD_LOGIC_VECTOR (4 downto 0);
           Vk           : in STD_LOGIC_VECTOR (31 downto 0);
           Qk           : in STD_LOGIC_VECTOR (4 downto 0);
           Vj           : in STD_LOGIC_VECTOR (31 downto 0);
           Qj           : in STD_LOGIC_VECTOR (4 downto 0);
           CDB_V_IN     : in STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q_IN     : in STD_LOGIC_VECTOR (4 downto 0);
           Grand_in_A   :in STD_LOGIC;
           Grand_in_L   :in STD_LOGIC;
           Fu_type      : in STD_LOGIC_VECTOR (1 downto 0);
           Stop_In          : in STD_LOGIC;
           
           ID_out       : out std_logic_vector(4 downto 0);
           Poke_out_A   :out STD_LOGIC;
           Poke_out_L   :out STD_LOGIC;           
           Result       : out STD_LOGIC_VECTOR (31 downto 0);
           Tag_out      : out STD_LOGIC_VECTOR (4 downto 0);
           Free_a_out : out STD_LOGIC;
           Free_l_out : out STD_LOGIC);
end component;

component Issue is
    Port ( 
           CLK       : in STD_LOGIC;
           Issue_in  : in STD_LOGIC;         
           RS_l_FREE   : in STD_LOGIC;
           Rs_a_FREE   : in STD_LOGIC;
           Fu_type   : in STD_LOGIC_VECTOR (1 downto 0);
           FOp         : in STD_LOGIC_VECTOR (1 downto 0);
           R_dest_IN : in STD_LOGIC_VECTOR (4 downto 0);
           Rk_addr_IN  : in STD_LOGIC_VECTOR (4 downto 0);
           Rj_addr_IN  : in STD_LOGIC_VECTOR (4 downto 0);
           
           
           OPCODE       : out STD_LOGIC_VECTOR (4 downto 0);
           R_dest        : out STD_LOGIC_VECTOR (4 downto 0);
           Rk_addr      : out STD_LOGIC_VECTOR (4 downto 0);
           Rj_addr      : out STD_LOGIC_VECTOR (4 downto 0);
           Accepted      : out STD_LOGIC;
           Stop : out STD_LOGIC);
end component;

component RF is
    Port ( CLK     : in STD_LOGIC;
           RST     : in STD_LOGIC;
           CDB_Q   : in STD_LOGIC_VECTOR (4 downto 0);
           R_Dest  : in STD_LOGIC_VECTOR (4 downto 0);
           Rk_addr : in STD_LOGIC_VECTOR (4 downto 0);
           Rj_addr : in STD_LOGIC_VECTOR (4 downto 0);         
           CDB_V    : in STD_LOGIC_VECTOR (31 downto 0);
           RS_ID    : in STD_LOGIC_VECTOR (4 downto 0);
           
           Qk_out :out STD_LOGIC_VECTOR (4 downto 0);
           Qj_out :out STD_LOGIC_VECTOR (4 downto 0);
           Rk_V     : out STD_LOGIC_VECTOR (31 downto 0);
           Rj_V     : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component CDB is
    Port ( 
            CLK :  in STD_LOGIC;
           CDB_V_IN : in STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q_IN : in STD_LOGIC_VECTOR (4 downto 0);
           CDB_V_OUT : out STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q_OUT : out STD_LOGIC_VECTOR (4 downto 0);
           GRAND    : out STD_LOGIC_VECTOR (1 downto 0);
           POKE     : in STD_LOGIC_VECTOR (1 downto 0));
end component;


begin

Issue_Unit: Issue
Port Map(
        CLK       =>clk,
        Issue_in  =>issue_in,
        RS_a_FREE   =>free_a_out_tmp,
        RS_l_FREE   =>free_l_out_tmp,
        Fu_type   =>fu_type,
        FOp       =>fop,
        R_dest_IN =>r_dest,
        Rk_addr_IN=>rk_addr,
        Rj_addr_IN=>rj_addr,
        
        STOP    =>stop_tmp,                
        OPCODE    =>opcode_tmp,
        R_dest    =>r_dest_tmp,
        Rk_addr   =>rk_addr_tmp,
        Rj_addr   =>rj_addr_tmp,
        
        Accepted  =>accepted);



CDB_Unit:CDB
Port Map(
        CLK      =>clk,
        CDB_V_IN =>MC_Res_tmp,
        CDB_Q_IN =>MC_tag_tmp,
        CDB_V_OUT=>CDB_V_tmp ,
        CDB_Q_OUT=>CDB_Q_tmp ,
        GRAND    =>grand_tmp ,
        POKE     =>poke_tmp  ); 

RF_Unit: RF
Port Map(
         CLK     =>clk,
         RST     =>reset    ,
         CDB_Q   =>CDB_Q_tmp  ,
         R_Dest  =>R_dest_tmp ,
         Rk_addr =>Rk_addr_tmp,
         Rj_addr =>Rj_addr_tmp,
         CDB_V   =>CDB_V_tmp  ,
         RS_ID   =>rs_id_tmp  ,  
         Qk_out  =>QK_OUT_tmp ,         
         Qj_out  =>Qj_OUT_tmp ,
         Rk_V    =>rk_v_tmp   ,
         Rj_V    =>rj_v_tmp   );
         


MC_Unit: MC
Port Map(
        CLK       =>clk,
        Fu_type   =>fu_type,
        OpCode    =>opcode_tmp  ,
        Vk        =>rk_v_tmp    ,
        Qk        =>QK_OUT_tmp  ,
        Vj        =>rj_v_tmp    ,
        Qj        =>Qj_OUT_tmp  ,
        CDB_V_IN  =>CDB_V_tmp   ,
        CDB_Q_IN  =>CDB_q_tmp   ,
        Grand_in_A=>grand_tmp(1),
        Grand_in_L=>grand_tmp(0), 
        STOP_in   =>stop_tmp,
                 
        ID_out    =>RS_ID_tmp   ,
        Poke_out_A=>poke_tmp(1) ,
        Poke_out_L=>poke_tmp(0) ,
        Result    =>MC_Res_tmp  ,
        Tag_out   =>MC_Tag_tmp  ,
        Free_a_out  =>free_a_out_tmp,
        Free_l_out  =>free_l_out_tmp);


end Behavioral;
