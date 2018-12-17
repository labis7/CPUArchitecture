----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/14/2018 11:15:59 AM
-- Design Name: 
-- Module Name: FU_Logical - Behavioral
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
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FU_Logical is
    Port ( CLK : in  STD_LOGIC;
       EN : in  STD_LOGIC;
       OP : in  STD_LOGIC_VECTOR (1 downto 0);
       Vk : in  STD_LOGIC_VECTOR (31 downto 0);
       Vj : in  STD_LOGIC_VECTOR (31 downto 0);
       Tag_IN : in  STD_LOGIC_VECTOR (4 downto 0);
       Grand : in  STD_LOGIC;
       
       full_out : out  STD_LOGIC;  
       Result_L : out  STD_LOGIC_VECTOR (31 downto 0);
       Tag_1  : out  STD_LOGIC_VECTOR (4 downto 0);
       Tag_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
       Poke_L : out  STD_LOGIC);
end FU_Logical;

architecture Behavioral of FU_Logical is

signal  en1_tmp,en2_tmp: std_logic;
signal  tag1_tmp,tag2_tmp:STD_LOGIC_VECTOR (4 downto 0):=(others => '1');
signal  vk_tmp,vj_tmp,res0_tmp,res1_tmp,res2_tmp :STD_LOGIC_VECTOR (31 downto 0);


component Reg_32bit 
Port (
      CLK 			: in  STD_LOGIC;
      Input_32bit   : in  STD_LOGIC_VECTOR (31 downto 0);
      Reset 		: in  STD_LOGIC;
      EN 			: in  STD_LOGIC;
      Output_32bit  : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component Reg_5bit
Port( 
      CLK         : in  STD_LOGIC;
      EN          : in  STD_LOGIC;
      Reset       : in  STD_LOGIC;
      Input_5bit  : in  STD_LOGIC_VECTOR (4 downto 0);
      Output_5bit : out  STD_LOGIC_VECTOR (4 downto 0));
end component;


begin


Tag_Delay1 :Reg_5bit
Port Map( CLK 			 =>CLK,
          Input_5bit     =>tag_in,
          Reset 		 =>'0',
          EN 			 =>en1_tmp,	     -- elegxetai apo microcontroller, opoios tha dei ama einai full,se kathe allh periptwsh(exei den exei plhroforia), to EN1=1, otan den exei plhroforia to tag=11111
          Output_5bit    =>tag1_tmp );
			 
Tag_Delay2 :Reg_5bit
Port Map( CLK 			 =>CLK,
          Input_5bit     =>tag1_tmp,
          Reset 		 =>'0',
          EN 			 =>EN2_tmp,	
          Output_5bit    =>tag2_tmp );
			 

						 
Reg32bit_delay1 :Reg_32bit
Port Map( CLK 			 =>CLK,
          Input_32bit    =>res0_tmp,
          Reset 		 =>'0',
          EN 			 =>en1_tmp, -- elegxetai apo microcontroller, opoios tha dei ama einai full,se kathe allh periptwsh(exei den exei plhroforia), to EN1=1	
          Output_32bit   =>res1_tmp );
			 
Reg32bit_delay2 :Reg_32bit
Port Map( CLK 			 =>CLK,
          Input_32bit    =>res1_tmp,
          Reset 		 =>'0',
          EN 			 =>EN2_tmp,	
          Output_32bit   =>Result_L );
			 
tag_out <= tag2_tmp;			 
tag_1 <= tag1_tmp;
A_alu : process(op,tag_in,res0_tmp,clk,tag1_tmp,tag2_tmp,grand,EN)
variable full : std_logic;
begin


if (((tag1_tmp/="11111")and(tag2_tmp/="11111")and((tag1_tmp(0)='0')OR(tag1_tmp(0)='1'))And((tag2_tmp(0)='0')OR(tag2_tmp(0)='1'))) AND(grand='0')) then full:='1';
    else full:= '0' ;
    end if;

 -----------------------------spasimo arxikhs sunthikhs
 if((tag1_tmp(0)/='0')AND(tag1_tmp(0)/='1')) then        en1_tmp<='1';
 
 -----------------------------
 else 
         en1_tmp<=EN;
         --vk_tmp<=vk;
         --vj_tmp<=vj;
         
         
         
         ----------------------------------------
         if((tag_in /="11111")AND(EN='1')) then -- diladi o microcontroller tha exei elegxei to full, opote ama dwsei en, thaxei kai kati kainourgio
             if(op="00") then res0_tmp<= (vk or vj);
             elsif(op="01") then res0_tmp<=( vk and vj);
             elsif(op="10") then res0_tmp<= NOT (vk);
             else null;
             end if;
         else null;
         end if;
         ----------------------------------------
 
         if(full='1') then en2_tmp<='0';
         else en2_tmp<='1';
         end if;
         
         if((tag2_tmp/="11111")AND(grand='0')) then en2_tmp<='0'; 
--             if(tag2_tmp/="11111") then en2_tmp<='0';
--             else null;
--             end if;
         else en2_tmp<='1';
         end if;
         --elegxo gia na steilei poke
         if(((tag1_tmp/="11111")and(((tag2_tmp/="11111")and(grand='1'))or(tag2_tmp="11111")))OR((tag2_tmp/="11111")and(GRAND='0'))) then poke_L<='1';
         else poke_L<='0';
         end if;
 end if;
 if((tag2_tmp(0)/='0')AND(tag2_tmp(0)/='1')) then        en2_tmp<='1'; end if ;

full_out<=full;
end process;

end Behavioral;
