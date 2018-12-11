----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2018 08:44:54 PM
-- Design Name: 
-- Module Name: CDB_Bench - Behavioral
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



library ieee;
use ieee.std_logic_1164.all;

entity tb_CDB is
end tb_CDB;

architecture tb of tb_CDB is

    component CDB
        port (clk       : in STD_LOGIC;
              CDB_V_IN  : in std_logic_vector (31 downto 0);
              CDB_Q_IN  : in std_logic_vector (4 downto 0);
              CDB_V_OUT : out std_logic_vector (31 downto 0);
              CDB_Q_OUT : out std_logic_vector (4 downto 0);
              GRAND     : out std_logic_vector (1 downto 0);
              POKE      : in std_logic_vector (1 downto 0));
    end component;

    signal CDB_V_IN  : std_logic_vector (31 downto 0);
    signal CDB_Q_IN  : std_logic_vector (4 downto 0);
    signal CDB_V_OUT : std_logic_vector (31 downto 0);
    signal CDB_Q_OUT : std_logic_vector (4 downto 0);
    signal GRAND     : std_logic_vector (1 downto 0);
    signal POKE      : std_logic_vector (1 downto 0);
    signal clk       : STD_LOGIC;

 constant CLK_period : time := 10 ns; 
begin

    dut : CDB
    port map (CDB_V_IN  => CDB_V_IN,
              CDB_Q_IN  => CDB_Q_IN,
              CDB_V_OUT => CDB_V_OUT,
              CDB_Q_OUT => CDB_Q_OUT,
              GRAND     => GRAND,
              clk => clk,
              POKE      => POKE);

  CLK_process :process
      begin
           CLK <= '0';
           wait for CLK_period/2;
           CLK <= '1';
           wait for CLK_period/2;
      end process;



    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CDB_V_IN <= (others => '0');
        CDB_Q_IN <= (others => '0');
        POKE <= (others => '0');

  
        
  
        wait for 15 ns;
        POKE <= "11";
        --wait for 5 ns;
        
       -- CDB_V_IN <="00000000000000000000000000000000";        
       -- CDB_Q_IN <= "11111";
        
       
       -- CDB_Q_IN <= "01001";
        --CDB_V_IN <="00000000000000000000000000000010"; 
        wait for 30 ns;
        POKE <= "10";
        CDB_V_IN <="00000000000000000000000000000001";
        CDB_Q_IN <= "01001"; 
        wait for 10 ns;
        POKE <= "01";
        CDB_V_IN <="00000000000000000000000000000001";
        CDB_Q_IN <= "00001";
        wait for 10 ns;
        CDB_Q_IN <= "11111";
        POKE <= "00";
        --CDB_Q_IN <= "11111";
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_CDB of tb_CDB is
    for tb
    end for;
end cfg_tb_CDB;