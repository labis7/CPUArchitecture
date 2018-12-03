----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:03:33 07/11/2018 
-- Design Name: 
-- Module Name:    RS_Logical - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RS_Logical is
    Port ( CLK : in  STD_LOGIC;
           EN_RS1 : in  STD_LOGIC_VECTOR(2 downto 0);
		   EN_RS2 : in  STD_LOGIC_VECTOR(2 downto 0);
		   
			  
           OpCode_RS1_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           OpCode_RS2_IN : in  STD_LOGIC_VECTOR (4 downto 0);
          
           		  
		   Qk_RS1_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           Qk_RS2_IN : in  STD_LOGIC_VECTOR (4 downto 0);        
		   Qj_RS1_IN : in  STD_LOGIC_VECTOR (4 downto 0);
           Qj_RS2_IN : in  STD_LOGIC_VECTOR (4 downto 0);
			  
		   Vk_RS1_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           Vk_RS2_IN : in  STD_LOGIC_VECTOR (31 downto 0);
		   Vj_RS1_IN : in  STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS2_IN : in  STD_LOGIC_VECTOR (31 downto 0);
			  
			  
			  
		   Rb :   out  STD_LOGIC_VECTOR (1 downto 0);
           Free_out   : out  STD_LOGIC_VECTOR(1 downto 0);  
			  
		   OpCode_RS1_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
           OpCode_RS2_OUT : out  STD_LOGIC_VECTOR (4 downto 0);
			  
		   ID_RS1_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
		   ID_RS2_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
			  
  		   Qk_RS1_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
           Qk_RS2_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
		   Qj_RS1_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);
           Qj_RS2_OUT : OUT  STD_LOGIC_VECTOR (4 downto 0);

			  
		   Vk_RS1_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0);
           Vk_RS2_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0);
		   Vj_RS1_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS2_OUT : OUT  STD_LOGIC_VECTOR (31 downto 0));
end RS_Logical;

architecture Behavioral of RS_Logical is


signal Qk_RS1_tmp,Qk_RS2_tmp,Qj_RS1_tmp,Qj_RS2_tmp :STD_LOGIC_VECTOR(4 downto 0);
signal free_out_tmp  :STD_LOGIC_VECTOR(1 downto 0);
signal opcode_rs1_out_tmp,opcode_rs2_out_tmp :STD_LOGIC_VECTOR(4 downto 0);


COMPONENT RS_part
    Port ( CLK			: IN    STD_LOGIC;
		   EN			: IN    STD_LOGIC_VECTOR(2 downto 0);
			 
 		   OpCode_in : in  STD_LOGIC_VECTOR (4 downto 0);
		   Vk_in 		: in  STD_LOGIC_VECTOR (31 downto 0);
           Vj_in 		: in  STD_LOGIC_VECTOR (31 downto 0);
		   Qk_in 		: in  STD_LOGIC_VECTOR (4 downto 0);
           Qj_in 		: in  STD_LOGIC_VECTOR (4 downto 0);
			  
           Qk_out 	: out  STD_LOGIC_VECTOR (4 downto 0);
           Qj_out 	: out  STD_LOGIC_VECTOR (4 downto 0);
		   Vk_out 	: out  STD_LOGIC_VECTOR (31 downto 0);
           Vj_out 	: out  STD_LOGIC_VECTOR (31 downto 0);
		   ID_in  	: in   STD_LOGIC_VECTOR (4 downto 0);
		   ID_out  	: out  STD_LOGIC_VECTOR (4 downto 0);
           OpCode_out: out  STD_LOGIC_VECTOR (4 downto 0));    
end component;

begin

RS1_L:RS_part
Port Map(CLK			=>CLK	        ,
         EN				=>EN_RS1		,
         OpCode_in	    =>OpCode_RS1_IN ,
         Vk_in 		    =>Vk_RS1_IN	    ,
         Vj_in 		    =>Vj_RS1_IN 	,
         Qk_in 		    =>Qk_RS1_IN	    ,
         Qj_in 		    =>Qj_RS1_IN	 	,
							
        
         Vk_out 		=>Vk_RS1_OUT 	 , 
         Vj_out 		=>Vj_RS1_OUT 	 ,
		 Qk_out 		=>Qk_RS1_tmp 	 ,
         Qj_out 		=>Qj_RS1_tmp 	 ,
         ID_in  		=>"00100"    	 ,													
         ID_out  		=> ID_RS1_OUT	 ,
         OpCode_out     => OpCode_RS1_OUT_TMP); 
         
OpCode_RS1_OUT <= OpCode_RS1_OUT_tmp;
free_out_tmp(1) <=OpCode_RS1_OUT_tmp(4);      

RS2_L:RS_part
Port Map(CLK			=>CLK	       ,
         EN				=>EN_RS2       ,
         OpCode_in	    =>OpCode_RS2_IN,
         Vk_in 		    =>Vk_RS2_IN	   ,
         Vj_in 		    =>Vj_RS2_IN    ,
         Qk_in 		    =>Qk_RS2_IN	   ,
         Qj_in 		    =>Qj_RS2_IN	   ,
								
                       
         Vk_out 		=>Vk_RS2_OUT 	, 
         Vj_out 		=>Vj_RS2_OUT 	,
		 Qk_out 		=>Qk_RS2_tmp 	,
         Qj_out 		=>Qj_RS2_tmp 	,
         ID_in  		=>"00101"    	,
         ID_out  		=> ID_RS2_OUT	,
         OpCode_out     => OpCode_RS2_OUT_TMP ); 
 
OpCode_RS2_OUT <= OpCode_RS2_OUT_tmp;
free_out_tmp(0) <=OpCode_RS2_OUT_tmp(4);
         

Qk_RS1_OUT <= Qk_RS1_tmp;
Qk_RS2_OUT <= Qk_RS2_tmp;

Qj_RS1_OUT <= Qj_RS1_tmp;
Qj_RS2_OUT <= Qj_RS2_tmp;

free_out <= free_out_tmp;


Ready_to_Run : process (clk,free_out_tmp)
begin

    if ((Qk_RS1_tmp="11111" AND Qj_RS1_tmp="11111")  AND (free_out_tmp(1)='0'))  then Rb(1)<='1';
    else Rb(1)<='0';
    end if;
    
    if ((Qk_RS2_tmp="11111" AND Qj_RS2_tmp="11111")  AND (free_out_tmp(0)='0')) then Rb(0)<='1';
    else Rb(0)<='0';
    end if;
 


end process;



end Behavioral;

