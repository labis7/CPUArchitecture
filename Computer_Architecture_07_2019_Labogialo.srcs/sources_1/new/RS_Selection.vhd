----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/14/2018 12:55:11 PM
-- Design Name: 
-- Module Name: RS_Selection - Behavioral
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

entity RS_Selection is
    Port ( 
           clk       : in STD_LOGIC;
           Vk_RS1_in : in STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS1_in : in STD_LOGIC_VECTOR (31 downto 0);
           Vk_RS2_in : in STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS2_in : in STD_LOGIC_VECTOR (31 downto 0);
           Vk_RS3_in : in STD_LOGIC_VECTOR (31 downto 0);
           Vj_RS3_in : in STD_LOGIC_VECTOR (31 downto 0);
           Rb : in STD_LOGIC_VECTOR (2 downto 0);
           
           Vk_out : out STD_LOGIC_VECTOR (31 downto 0);
           Vj_out : out STD_LOGIC_VECTOR (31 downto 0));
end RS_Selection;

architecture Behavioral of RS_Selection is

--signal round_robin : STD_LOGIC_VECTOR(1 downto 0);

begin

Selection : process(clk,Rb)
begin
if (Rb(2)='1') then     
    Vk_out <= Vk_RS1_in;
    Vj_out <= Vj_RS1_in;
elsif (Rb(1)='1') then       
     Vk_out <= Vk_RS2_in;
     Vj_out <= Vj_RS2_in;
elsif (Rb(0)='1') then       
     Vk_out <= Vk_RS3_in;
     Vj_out <= Vj_RS3_in;   
else null;
end if;
end process;


end Behavioral;
