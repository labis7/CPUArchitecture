----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:27 07/11/2018 
-- Design Name: 
-- Module Name:    RS_part - Behavioral 
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


entity RS_part is
    Port (    CLK: IN    STD_LOGIC;
			  EN: IN    STD_LOGIC_VECTOR(2 downto 0);
 			  OpCode_in : in  STD_LOGIC_VECTOR (4 downto 0);
			  Vk_in : in  STD_LOGIC_VECTOR (31 downto 0);
              Vj_in : in  STD_LOGIC_VECTOR (31 downto 0);
			  Qk_in : in  STD_LOGIC_VECTOR (4 downto 0);
              Qj_in : in  STD_LOGIC_VECTOR (4 downto 0);
			      
              Qk_out : out  STD_LOGIC_VECTOR (4 downto 0);
              Qj_out : out  STD_LOGIC_VECTOR (4 downto 0);
			  Vk_out : out  STD_LOGIC_VECTOR (31 downto 0);
              Vj_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ID_in  	: in  STD_LOGIC_VECTOR (4 downto 0);
			  ID_out  	: out  STD_LOGIC_VECTOR (4 downto 0);
              OpCode_out : out  STD_LOGIC_VECTOR (4 downto 0));
       
end RS_part;

architecture Behavioral of RS_part is


component Reg_32bit 
Port (CLK 			: in  STD_LOGIC;
      Input_32bit : in  STD_LOGIC_VECTOR (31 downto 0);
      Reset 		: in  STD_LOGIC;
      EN 			: in  STD_LOGIC;
      Output_32bit : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component Reg_5bit
Port( CLK : in  STD_LOGIC;
      EN : in  STD_LOGIC;
      Reset : in  STD_LOGIC;
      Input_5bit : in  STD_LOGIC_VECTOR (4 downto 0);
      Output_5bit : out  STD_LOGIC_VECTOR (4 downto 0));
end component;

Component Reg_1bit
Port( CLK : in  STD_LOGIC;
      EN : in  STD_LOGIC;
      Reset : in  STD_LOGIC;
      Input_1bit : in  STD_LOGIC;
      Output_1bit : out  STD_LOGIC);
end component;

--SIGNAL  Qk_out_tmp,Qj_out_tmp :  std_logic_vector(4 downto 0);


begin

ID_OUT<=ID_IN;


OpCode_Reg :Reg_5bit
Port Map( CLK 			 =>CLK,
          Input_5bit =>OpCode_in,
          Reset 		 =>'0',
          EN 			 =>EN(2),	
          Output_5bit=>OpCode_out );
			 			 
			 
			 
Vk_Reg :Reg_32bit
Port Map( CLK 			 =>CLK,
          Input_32bit =>Vk_in,
          Reset 		 =>'0',
          EN 			 =>EN(1),	
          Output_32bit=>Vk_out );
			 
Vj_Reg :Reg_32bit
Port Map( CLK 			 =>CLK,
          Input_32bit =>Vj_in,
          Reset 		 =>'0',
          EN 			 =>EN(0),	
          Output_32bit=>Vj_out );



Qk_Reg :Reg_5bit
Port Map( CLK 			 =>CLK,
          Input_5bit =>Qk_in,
          Reset 		 =>'0',
          EN 			 =>EN(1),	
          Output_5bit=>Qk_out );
			 
Qj_Reg :Reg_5bit
Port Map( CLK 			 =>CLK,
          Input_5bit =>Qj_in,
          Reset 		 =>'0',
          EN 			 =>EN(0),	
          Output_5bit=>Qj_out );			 




--
--rb_check: process(Qk_in,Qj_in,EN)
--begin 
--	if((Qk_in = "11111")AND(Qj_in = "11111")AND(EN(1 downto 0) = "11")) then
--		  RB<= '1';
--	else RB<= '0';
--	end if;
--END process;



end Behavioral;


