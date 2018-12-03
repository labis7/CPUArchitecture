----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:12:33 07/13/2018 
-- Design Name: 
-- Module Name:    Reg_5bit - Behavioral 
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

entity Reg_5bit is
    Port ( CLK : in  STD_LOGIC;
           EN : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Input_5bit : in  STD_LOGIC_VECTOR (4 downto 0);
           Output_5bit : out  STD_LOGIC_VECTOR (4 downto 0));
end Reg_5bit;

architecture Behavioral of Reg_5bit is


begin
process (clk,reset) is  
begin
if(rising_edge(clk)) then
  if(RESET='1') then Output_5bit<="11111";
  elsif (EN = '1') then
      Output_5bit<=  Input_5bit;
  ELSE null;
  END IF;
end if;

end process;


end Behavioral;


