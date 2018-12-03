----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/09/2018 12:16:55 PM
-- Design Name: 
-- Module Name: CDB - Behavioral
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

entity CDB is
    Port ( clk : in STD_LOGIC;
           CDB_V_IN : in STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q_IN : in STD_LOGIC_VECTOR (4 downto 0);
           CDB_V_OUT : out STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q_OUT : out STD_LOGIC_VECTOR (4 downto 0);
           GRAND : out STD_LOGIC_VECTOR (1 downto 0);
           POKE : in STD_LOGIC_VECTOR (1 downto 0));
end CDB;

architecture Behavioral of CDB is

begin

CDB_V_OUT <= CDB_V_IN;
CDB_Q_OUT <= CDB_Q_IN;
CDB_PROC:PROCESS(CLK,CDB_V_IN,CDB_q_IN,poke)
variable RR_BIT : std_logic;
BEGIN


IF(RISING_EDGE(CLK)) THEN 
------------------------------
   if(RR_BIT/= '1') then 
      RR_BIT:='1';
   ELSE  
      RR_BIT:='0';
   END IF;
-------------------------------
 
-------------------------------   
   IF (poke= "11") then 
       IF(RR_BIT ='1') THEN grand<="10";
       ELSE grand<="01";
       END IF;
   elsif (poke(1)= '1') then grand<="10";
   elsif (poke(0)= '1') then grand<="01";
   else grand<="00";
   end if;
   

-------------------------------

------------------------------- 
  --  IF(POKE="00") then 
  --     CDB_Q_OUT <= "11111";--KWDIKAS ASFALEIAS
   -- ELSE
        
  --  END IF;
-------------------------------

ELSE null;
END IF;

END PROCESS;
end Behavioral;
