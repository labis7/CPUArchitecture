----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/09/2018 10:51:52 AM
-- Design Name: 
-- Module Name: RF_Bench - Behavioral
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

entity tb_RF is
end tb_RF;

architecture tb of tb_RF is

    component RF
        port (CLK     : in std_logic;
              RST     : in std_logic;
              CDB_Q   : in std_logic_vector (4 downto 0);
              R_Dest  : in std_logic_vector (4 downto 0);
              Rk_addr : in std_logic_vector (4 downto 0);
              Rj_addr : in std_logic_vector (4 downto 0);
              CDB_V   : in std_logic_vector (31 downto 0);
              RS_ID   : in std_logic_vector (4 downto 0);
              Rk_V    : out std_logic_vector (31 downto 0);
              Rj_V    : out std_logic_vector (31 downto 0));
    end component;

    signal CLK     : std_logic;
    signal RST     : std_logic;
    signal CDB_Q   : std_logic_vector (4 downto 0);
    signal R_Dest  : std_logic_vector (4 downto 0);
    signal Rk_addr : std_logic_vector (4 downto 0);
    signal Rj_addr : std_logic_vector (4 downto 0);
    signal CDB_V   : std_logic_vector (31 downto 0);
    signal RS_ID   : std_logic_vector (4 downto 0);
    signal Rk_V    : std_logic_vector (31 downto 0);
    signal Rj_V    : std_logic_vector (31 downto 0);

constant CLK_period : time := 10 ns; 

begin

    dut : RF
    port map (CLK     => CLK,
              RST     => RST,
              CDB_Q   => CDB_Q,
              R_Dest  => R_Dest,
              Rk_addr => Rk_addr,
              Rj_addr => Rj_addr,
              CDB_V   => CDB_V,
              RS_ID   => RS_ID,
              Rk_V    => Rk_V,
              Rj_V    => Rj_V);

    -- Clock generation
       CLK_process :process
    begin
         CLK <= '0';
         wait for CLK_period/2;
         CLK <= '1';
         wait for CLK_period/2;
    end process;-- EDIT: Check that clk is really your main clock signal

    stimuli : process
    begin
     -- EDIT Adapt initialization as needed
      CDB_Q   <= (others => '0');
      R_Dest  <= (others => '0');
      Rk_addr <= (others => '0');
      Rj_addr <= (others => '0');
      CDB_V   <= (others => '0');
      RS_ID   <= (others => '0');
       wait for 5 ns;
      -- Reset generation
      -- EDIT: Check that RST is really your reset signal
      RST <= '1';
      wait for 10 ns;--------------------------prosoxh eimai malakasss
      
      RST <= '0';
      wait for 10 ns;
      rs_id   <= "01001";
      R_dest  <= "00001";
      Rk_addr <= "00010";
      Rj_addr <= "00011";
      CDB_Q   <= "11111";
      CDB_V   <= "00000000000000000000000000000000";
      wait for 10 ns;
      R_dest  <= "00000";
      CDB_Q   <= "01001";
      CDB_V   <= "00000000000000000000000000000010";
      Rk_addr <= "00001";
      wait for 10 ns;
      R_dest  <= "00000";
      wait;

        -- EDIT Add stimuli here
        

        -- Stop the clock and hence terminate the simulation
    end process;
end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_RF of tb_RF is
    for tb
    end for;
end cfg_tb_RF;
