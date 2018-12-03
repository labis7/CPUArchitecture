----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:07 07/11/2018 
-- Design Name: 
-- Module Name:    Reg_32bit - Behavioral 
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

entity Reg_32bit is
    Port ( CLK : in  STD_LOGIC;
	        Input_32bit : in  STD_LOGIC_VECTOR (31 downto 0);
	        Reset : in  STD_LOGIC;
	        EN : in  STD_LOGIC;
	        Output_32bit : out  STD_LOGIC_VECTOR (31 downto 0)); 
end Reg_32bit;

architecture Behavioral of Reg_32bit is

begin
process (clk) is  
begin
if(rising_edge(clk)) then
  if(RESET='1') then Output_32bit<="00000000000000000000000000000000";
  elsif (EN = '1') then
      Output_32bit<=  Input_32bit;
  ELSE null;
  END IF;
end if;

end process;

end Behavioral;


