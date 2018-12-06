----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/06/2018 11:14:00 AM
-- Design Name: 
-- Module Name: ROB - Behavioral
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

entity ROB is
  Port ( CLK :IN STD_LOGIC;
         CDB_V
         CDB_Q
         Opcode  --4 bit. type kai op
         R_dest
         Rk
         Rj
         En
         
         
         
         
         
         
         --out
         ROB1_RES  --pigainoun MC gia na apofasisei an diale3ei auta h ton CDB kateutheian se ena corner case(blepe MC sxolia)
         ROB1_DEST
         ready
         exception_code
         Rob_ID --Asyxrona stelnetai to ID tou rob slot sto opoio prokeitai na graftei h entolh pou exei erthei TWRA
         Qk    -----auth h timh einai gia ta pedia q ths RS, h RS tha akouei sunexeia to cdb(opws kai kanei), wste na brei kapoio rob# na bouti3ei gia na to balei sta dedomena ths, pernaei prwta apo MC 
         Qj  --pernane prwta apo MC
         Vk   -- timh otan, ta q parapanw einai 11111(pou shmainei oti uparxei mesa ston ROB kai exei etoimh timh), to 00000 shmainei oti den uparxei(kai epilegoume RF gia ta values), enw se allh periptwsh ta Q koubalane to rob# pou perimenoume(V adiaforo)
         Vj

);
end ROB;

architecture Behavioral of ROB is

begin


end Behavioral;
