----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/15/2018 10:22:53 AM
-- Design Name: 
-- Module Name: FU_Arithmetic - Behavioral
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

entity FU_Arithmetic is
    Port ( CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
		   OP : in  STD_LOGIC_VECTOR (1 downto 0);
           Vk : in  STD_LOGIC_VECTOR (31 downto 0);
           Vj : in  STD_LOGIC_VECTOR (31 downto 0);
		   Tag_IN : in  STD_LOGIC_VECTOR (4 downto 0):=(others => '1');
           Grand : in  STD_LOGIC;
			
		   full_out : out  STD_LOGIC;
           Result_A : out  STD_LOGIC_VECTOR (31 downto 0);
           Tag_1  : out  STD_LOGIC_VECTOR (4 downto 0);
           Tag_2  : out  STD_LOGIC_VECTOR (4 downto 0);
           Tag_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
           Poke_A : out  STD_LOGIC);
end FU_Arithmetic;

architecture Behavioral of FU_Arithmetic is

signal  en1_tmp,en2_tmp,en3_tmp : std_logic;
signal   tag1_tmp,tag2_tmp,tag3_tmp :STD_LOGIC_VECTOR (4 downto 0) :=(others => '1');
signal vk_tmp,vj_tmp,res0_tmp,res1_tmp,res2_tmp,res3_tmp :STD_LOGIC_VECTOR (31 downto 0);

component Reg_32bit 
Port (CLK 			: in  STD_LOGIC;
      Input_32bit   : in  STD_LOGIC_VECTOR (31 downto 0);
      Reset 		: in  STD_LOGIC;
      EN 			: in  STD_LOGIC;
      Output_32bit  : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component Reg_5bit
Port( CLK         : in  STD_LOGIC;
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
          EN 			 =>en1_tmp,	     -- elegxetai apo microcontroller,o opoios tha dei ama einai full,se kathe allh periptwsh(exei den exei plhroforia), to EN1=1, otan den exei plhroforia to tag=11111
          Output_5bit    =>tag1_tmp );
			 
Tag_Delay2 :Reg_5bit
Port Map( CLK 			 =>CLK,
          Input_5bit     =>tag1_tmp,
          Reset 		 =>'0',
          EN 			 =>EN2_tmp,	
          Output_5bit    =>tag2_tmp );
			 
Tag_Delay3 :Reg_5bit
Port Map( CLK 			 =>CLK,
          Input_5bit     =>tag2_tmp,
          Reset 		 =>'0',
          EN 			 =>EN3_tmp,	
          Output_5bit    =>tag3_tmp );
			 			 
						 
						 
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
          Output_32bit   =>res2_tmp );
			 
Reg32bit_delay3 :Reg_32bit
Port Map( CLK 			 =>CLK,
          Input_32bit    =>res2_tmp,
          Reset 		 =>'0',
          EN 			 =>EN3_tmp,	
          Output_32bit   =>Result_A );

tag_1 <= tag1_tmp;
tag_2 <= tag2_tmp;
tag_out <= tag3_tmp;
			 
A_alu : process(op,tag_in,res0_tmp,tag1_tmp,tag2_tmp,tag3_tmp,clk,grand,EN)
variable full : std_logic;
begin
if (((tag1_tmp="01001")or(tag1_tmp="01010")or(tag1_tmp="01011")) and ((tag2_tmp="01001")or(tag2_tmp="01010")or(tag2_tmp="01011")) and ((tag3_tmp="01001")or(tag3_tmp="01010")or(tag3_tmp="01011")) AND(grand='0')) then full:='1';
    else full:= '0' ;
    end if;
--if (rising_edge(clk)) then

   -- if(((tag1_tmp/="11111")AND(tag2_tmp/="11111")AND(tag3_tmp/="11111"))AND(grand='0')) then full<='1';
    
    -----------------------------spasimo arxikhs sunthikhs
    if((tag1_tmp/="11111")AND(tag1_tmp/="01001")AND(tag1_tmp/="01010")AND(tag1_tmp/="01011")) then		en1_tmp<='1';
    
    -----------------------------
    else 
            en1_tmp<=EN;
            --vk_tmp<=vk;
            --vj_tmp<=vj;
            -----kapote edw itan to full (fool)
            
            
            ----------------------------------------
            if((tag_in /="11111")AND(EN='1')) then -- diladi o microcontroller tha exei elegxei to full, opote ama dwsei en, thaxei kai kati kainourgio
                if(op="00") then res0_tmp<= std_logic_vector(signed(vk) + signed(vj));
                elsif(op="01") then res0_tmp<= std_logic_vector(signed(vk) - signed(vj));
                elsif(op="10") then res0_tmp<= std_logic_vector(vk(30 downto 0)&'0');
                else null;
                end if;
            else null;
            end if;
            ----------------------------------------
    
            if(full='1') then en2_tmp<='0';
            else en2_tmp<='1';
            end if;
            
            if((tag3_tmp/="11111")AND(grand='0')) then en3_tmp<='0'; 
                if(tag2_tmp/="11111") then en2_tmp<='0';
                else null;
                end if;
            else en3_tmp<='1';
            end if;
            --elegxo gia na steilei poke
            if(((tag2_tmp/="11111")and(((tag3_tmp/="11111")and(grand='1'))or(tag3_tmp="11111")))OR((tag3_tmp/="11111")and(GRAND='0'))) then poke_A<='1'; --bug fixed
            else poke_A<='0';
            end if;
    end if;
    if((tag3_tmp/="11111")AND(tag3_tmp/="01001")AND(tag3_tmp/="01010")AND(tag3_tmp/="01011")) then		en3_tmp<='1'; end if;
    if((tag2_tmp/="11111")AND(tag2_tmp/="01001")AND(tag2_tmp/="01010")AND(tag2_tmp/="01011")) then		en2_tmp<='1'; end if ;
--else null;
--end if;
full_out<=full;
end process;
			 						 
end Behavioral;

