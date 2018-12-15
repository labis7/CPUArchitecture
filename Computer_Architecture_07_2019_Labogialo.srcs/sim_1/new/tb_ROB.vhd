----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/14/2018 05:34:48 PM
-- Design Name: 
-- Module Name: tb_ROB - Behavioral
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

entity tb_ROB is
--  Port ( );
end tb_ROB;

architecture tb of tb_ROB is
  component ROB
      port(CLK    :IN STD_LOGIC;
           CDB_V  : in STD_LOGIC_VECTOR (31 downto 0);
           CDB_Q  : in STD_LOGIC_VECTOR (4 downto 0);
           PC_in  : in STD_LOGIC_VECTOR (31 downto 0);
           Opcode_in : in STD_LOGIC_VECTOR (3 downto 0); --4 bit. type kai op
           R_dest : in STD_LOGIC_VECTOR (4 downto 0);
           Rk     : in STD_LOGIC_VECTOR (4 downto 0);
           Rj     : in STD_LOGIC_VECTOR (4 downto 0);
           En     : in STD_LOGIC;
           
           
           
           --out
           ROB1_RES      : out STD_LOGIC_VECTOR (31 downto 0);  --pigainoun MC gia na apofasisei an diale3ei auta h ton CDB kateutheian se ena corner case(blepe MC sxolia)
           ROB1_DEST     : out STD_LOGIC_VECTOR (4 downto 0);
           ready_out     : out STD_LOGIC;
           exception_code: out STD_LOGIC;
           Rob_ID        : out STD_LOGIC_VECTOR (4 downto 0);                    --Asyxrona stelnetai to ID tou rob slot sto opoio prokeitai na graftei h entolh pou exei erthei TWRA
           Qk            : out STD_LOGIC_VECTOR (4 downto 0);                    --auth h timh einai gia ta pedia q ths RS, h RS tha akouei sunexeia to cdb(opws kai kanei), wste na brei kapoio rob# na bouti3ei gia na to balei sta dedomena ths, pernaei prwta apo MC 
           Qj            : out STD_LOGIC_VECTOR (4 downto 0);                    --pernane prwta apo MC
           Vk            : out STD_LOGIC_VECTOR (31 downto 0);                    -- timh otan, ta q parapanw einai 11111(pou shmainei oti uparxei mesa ston ROB kai exei etoimh timh), to 00000 shmainei oti den uparxei(kai epilegoume RF gia ta values), enw se allh periptwsh ta Q koubalane to rob# pou perimenoume(V adiaforo)
           Vj            : out STD_LOGIC_VECTOR (31 downto 0));
  end component;
  
  signal clk       : STD_LOGIC;
  signal CDB_V     : std_logic_vector (31 downto 0);
  signal CDB_Q     : std_logic_vector (4 downto 0);
  signal PC_in     : std_logic_vector (31 downto 0);
  signal Opcode_in : std_logic_vector (3 downto 0);
  signal R_dest    : std_logic_vector (4 downto 0);
  signal Rk        : std_logic_vector (4 downto 0);
  signal Rj        : std_logic_vector (4 downto 0);
  signal En        : std_logic;
  
  
  signal ROB1_RES      :  STD_LOGIC_VECTOR (31 downto 0); 
  signal ROB1_DEST     :  STD_LOGIC_VECTOR (4 downto 0);  
  signal ready_out     :  STD_LOGIC;                      
  signal exception_code:  STD_LOGIC;                      
  signal Rob_ID        :  STD_LOGIC_VECTOR (4 downto 0);  
  signal Qk            :  STD_LOGIC_VECTOR (4 downto 0);  
  signal Qj            :  STD_LOGIC_VECTOR (4 downto 0);  
  signal Vk            :  STD_LOGIC_VECTOR (31 downto 0); 
  signal Vj            :  STD_LOGIC_VECTOR (31 downto 0);
  
  constant CLK_period : time := 10 ns; 
 
  
  
begin
dut : ROB
port map (clk       =>clk      ,
          CDB_V     =>CDB_V    , 
          CDB_Q     =>CDB_Q    ,
          PC_in     =>PC_in    ,
          Opcode_in =>Opcode_in,
          R_dest    =>R_dest   ,
          Rk        =>Rk       ,
          Rj        => Rj       ,
          En        => En       );




CLK_process :process
  begin
       CLK <= '0';
       wait for CLK_period/2;
       CLK <= '1';
       wait for CLK_period/2;
  end process;
   
   
   
    stimuli : process
    begin      
       CDB_V   <="00000000000000000000000000000001"; 
       CDB_Q   <="11111"; 
       PC_in   <="00000000000000000000000000000000";
       Opcode_in<="0100";
       R_dest   <="00001";
       Rk       <="00001";
       Rj       <="00001";
       En       <='0';
       wait for 5 ns;
       en <='1';
       wait for 10 ns;
       R_dest   <="00010";
       Rk       <="00010";
       Rj       <="00010";
       
       en <='1';
       
       wait for 10 ns;
        R_dest   <="00011";
        Rk       <="00010";
        Rj       <="00010";
        
        en <='1';
        
        CDB_V   <="00000000000000000000000000000001"; 
        CDB_Q   <="00001"; 
        --CDB_V   <="00000000000000000000000000000001"; 
        --CDB_Q   <="00010"; 
        
        wait for 10 ns;
         R_dest   <="00011";
         Rk       <="00010";
         Rj       <="00010";
               
         en <='1';
         wait for 10 ns;
        CDB_V   <="00000000000000000000000000000001"; 
        CDB_Q   <="11111"; 
        en <='0';
       wait;
       
       
    end process;
end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_ROB of tb_ROB is
    for tb
    end for;
end cfg_tb_ROB;