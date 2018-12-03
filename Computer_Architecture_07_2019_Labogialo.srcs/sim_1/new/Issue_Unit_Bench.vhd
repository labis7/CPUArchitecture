----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2018 08:13:23 PM
-- Design Name: 
-- Module Name: Issue_Unit_Bench - Behavioral
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

entity tb_Issue is
end tb_Issue;

architecture tb of tb_Issue is

    component Issue
        port (CLK        : in std_logic;
              Issue_in   : in std_logic;
              RS_FREE    : in std_logic;
              Fu_type    : in std_logic_vector (1 downto 0);
              FOp        : in std_logic_vector (1 downto 0);
              R_dest_IN  : in std_logic_vector (4 downto 0);
              Rk_addr_IN : in std_logic_vector (4 downto 0);
              Rj_addr_IN : in std_logic_vector (4 downto 0);
              OPCODE     : out std_logic_vector (4 downto 0);
              R_dest     : out std_logic_vector (4 downto 0);
              Rk_addr    : out std_logic_vector (4 downto 0);
              Rj_addr    : out std_logic_vector (4 downto 0);
              Accepted   : out std_logic;
              Stop       : out std_logic);
    end component;

    signal CLK        : std_logic;
    signal Issue_in   : std_logic;
    signal RS_FREE    : std_logic;
    signal Fu_type    : std_logic_vector (1 downto 0);
    signal FOp        : std_logic_vector (1 downto 0);
    signal R_dest_IN  : std_logic_vector (4 downto 0);
    signal Rk_addr_IN : std_logic_vector (4 downto 0);
    signal Rj_addr_IN : std_logic_vector (4 downto 0);
    signal OPCODE     : std_logic_vector (4 downto 0);
    signal R_dest     : std_logic_vector (4 downto 0);
    signal Rk_addr    : std_logic_vector (4 downto 0);
    signal Rj_addr    : std_logic_vector (4 downto 0);
    signal Accepted   : std_logic;
    signal Stop       : std_logic;

   constant CLK_period : time := 10 ns;  -- EDIT Put right period here



begin

    dut : Issue
    port map (CLK        => CLK,
              Issue_in   => Issue_in,
              RS_FREE    => RS_FREE,
              Fu_type    => Fu_type,
              FOp        => FOp,
              R_dest_IN  => R_dest_IN,
              Rk_addr_IN => Rk_addr_IN,
              Rj_addr_IN => Rj_addr_IN,
              OPCODE     => OPCODE,
              R_dest     => R_dest,
              Rk_addr    => Rk_addr,
              Rj_addr    => Rj_addr,
              Accepted   => Accepted,
              Stop       => Stop);

    -- Clock generation
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
        Issue_in <= '0';
        RS_FREE <= '0';
        Fu_type <= (others => '0');
        FOp <= (others => '0');
        R_dest_IN <= (others => '0');
        Rk_addr_IN <= (others => '0');
        Rj_addr_IN <= (others => '0');

        
        
        wait for 15 ns;
        Issue_in <= '1';
        RS_FREE <= '1';
        Fu_type <= "01";
        FOp     <= "00";
        R_dest_IN <= "00001";
        Rk_addr_IN <="00010";
        Rj_addr_IN <="00011";
        wait for 10 ns;
        R_dest_IN <= "00000";
        Issue_in <= '0';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Issue of tb_Issue is
    for tb
    end for;
end cfg_tb_Issue;