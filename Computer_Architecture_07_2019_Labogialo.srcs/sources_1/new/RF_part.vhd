----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/02/2018 02:20:50 PM
-- Design Name: 
-- Module Name: RF_part - Behavioral
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

entity RF_part is
    Port ( clk : in STD_LOGIC;
           En : in STD_LOGIC;
           R_in : in STD_LOGIC_VECTOR (31 downto 0);   -- auth h timh tha mpei apo cdb ean, ekeinh thn stigmh den exei zhthsei o issue gia eggrafh, epishs tha mpei kai an thn thelei san e3odo to ISSUE(rk,rj) kai apla tha ginei forward apo to cdb_v kateutheian sthn e3odo tou rk,rj, gia na mhn paroume thn palia timh
           RF_Q_IN : IN STD_LOGIC_VECTOR (4 downto 0);  ---E3artatai, ama cdb_q = *R_in* , tote antikathistw to RS_num(ID)
           rst : in STD_LOGIC;
           RF_Q_OUT : out STD_LOGIC_VECTOR (4 downto 0);
           R_OUT : OUT STD_LOGIC_VECTOR (31 downto 0));
end RF_part;

architecture Behavioral of RF_part is

begin
rf_part_proc: process (clk,rf_q_in,R_in,en)
begin
if(rst = '1') then 
    R_out<="00000000000000000000000000000001"; 
    RF_Q_OUT <= "11111";
end if;   
if ((RISING_EDGE(CLK))and(EN='1')) THEN 
    RF_Q_OUT <= RF_Q_IN;
    R_OUT <= R_in;
else
    null;
end if;

end process;

end Behavioral;
