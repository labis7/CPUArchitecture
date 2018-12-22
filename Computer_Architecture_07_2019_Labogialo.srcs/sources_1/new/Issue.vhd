----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2018 10:00:22 PM
-- Design Name: 
-- Module Name: Issue - Behavioral
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

entity Issue is
    Port ( 
           CLK : in STD_LOGIC;
           Issue_in : in STD_LOGIC;         
           RS_l_FREE   : in STD_LOGIC;
           Rs_a_FREE   : in STD_LOGIC;
           Fu_type : in STD_LOGIC_VECTOR (1 downto 0);
           FOp : in STD_LOGIC_VECTOR (1 downto 0);
           R_dest_IN : in STD_LOGIC_VECTOR (4 downto 0);
           Rk_addr_IN  : in STD_LOGIC_VECTOR (4 downto 0);
           Rj_addr_IN  : in STD_LOGIC_VECTOR (4 downto 0);
           
           OPCODE : out STD_LOGIC_VECTOR (4 downto 0);
           R_dest : out STD_LOGIC_VECTOR (4 downto 0);
           Rk_addr : out STD_LOGIC_VECTOR (4 downto 0);
           Rj_addr : out STD_LOGIC_VECTOR (4 downto 0);
           Accepted : out STD_LOGIC;
           Stop : out STD_LOGIC);
end Issue;

architecture Behavioral of Issue is

begin
IS_Proc : Process(clk,Rs_l_free,Rs_a_free,R_dest_in,Rk_addr_in,Rj_addr_in,FU_TYPE,FOP)
BEGIN
-- if((Issue_in='1') and (RS_free = '1')) then
--    stop<='0';
--    --Accepted <= '1';
-- else
-- stop<='1';
--       -- Accepted <= '0';
--end if;



if(Rising_edge(clk)) then 
    if((Issue_in='1') and (RS_a_free = '1')and(fu_type="01")) then
       opcode  <=  '0' & Fu_type & FOp;
       R_dest  <=  R_dest_IN;
       Rk_addr <=  Rk_addr_IN;
       Rj_addr <=  Rj_addr_IN;
       stop<='0';
       Accepted <= '1';
    elsif((Issue_in='1') and (RS_l_free = '1')and(fu_type="00")) then
           opcode  <=  '0' & Fu_type & FOp;
           R_dest  <=  R_dest_IN;
           Rk_addr <=  Rk_addr_IN;
           Rj_addr <=  Rj_addr_IN;
           stop<='0';
           Accepted <= '1';
    elsif((Issue_in='1')and(fu_type/="01")and(fu_type/="00")and((fu_type(0)='0')or(fu_type(0)='1'))) then
        opcode  <=  '0' & Fu_type & FOp;
        R_dest  <=  R_dest_IN;
        Rk_addr <=  Rk_addr_IN;
        Rj_addr <=  Rj_addr_IN;
        stop<='1';
        Accepted <= '1';
    
     else 
           
            
           R_dest  <= "00000"; --gia na mhn energopoihthei (enswmatwmeno)enable sto RF
           --if(Issue_in='0') then     
                stop<='1';
         -- else
              --  stop<='0';
          -- end if; 
           Accepted <= '0';
     end if;
else null; 
end if;


END PROCESS;

end Behavioral;
