-- Testbench automatically generated online
-- at http://vhdl.lapinoo.net
-- Generation date : 19.7.2018 08:02:39 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_MC_RS_FU_A is
end tb_MC_RS_FU_A;

architecture tb of tb_MC_RS_FU_A is

    component MC_RS_FU_A
        port (clk        : in std_logic;
              Grand_in_A : in std_logic;
              Vk         : in std_logic_vector (31 downto 0);
              Vj         : in std_logic_vector (31 downto 0);
              Qk         : in std_logic_vector (4 downto 0);
              Qj         : in std_logic_vector (4 downto 0);
              CDB_V      : in std_logic_vector (31 downto 0);
              CDB_Q      : in std_logic_vector (4 downto 0);
              OpCode     : in std_logic_vector (4 downto 0);
              Stop          : in STD_LOGIC;
              Poke_out_A : out std_logic;
              Res_A      : out std_logic_vector (31 downto 0);
              ID_A_OUT   : out std_logic_vector (4 downto 0);
              Tag_A      : out std_logic_vector (4 downto 0);
              Free_A     : out std_logic);
    end component;

    signal clk        : std_logic;
    signal Grand_in_A : std_logic;
    signal Vk         : std_logic_vector (31 downto 0);
    signal Vj         : std_logic_vector (31 downto 0);
    signal Qk         : std_logic_vector (4 downto 0);
    signal Qj         : std_logic_vector (4 downto 0);
    signal CDB_V      : std_logic_vector (31 downto 0);
    signal CDB_Q      : std_logic_vector (4 downto 0);
    signal OpCode     : std_logic_vector (4 downto 0);
    signal Poke_out_A : std_logic;
    signal Res_A      : std_logic_vector (31 downto 0);
    signal ID_A_OUT   : std_logic_vector (4 downto 0);
    signal Tag_A      : std_logic_vector (4 downto 0);
    signal Free_A     : std_logic;
    signal Stop       : STD_LOGIC;
 
constant CLK_period : time := 10 ns;

begin

    dut : MC_RS_FU_A
    port map (clk        => clk,
              Grand_in_A => Grand_in_A,
              Vk         => Vk,
              Vj         => Vj,
              Qk         => Qk,
              Qj         => Qj,
              CDB_V      => CDB_V,
              CDB_Q      => CDB_Q,
              OpCode     => OpCode,
              stop       => stop,
              Poke_out_A => Poke_out_A,
              Res_A      => Res_A,
              ID_A_OUT   => ID_A_OUT,
              Tag_A      => Tag_A,
              Free_A     => Free_A);

    -- Clock generation
 -- Clock process definitions
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
        Grand_in_A <= '0';
        Vk <= (others => '0');
        Vj <= (others => '0');
        Qk <= (others => '0');
        Qj <= (others => '0');
        CDB_V <= (others => '0');
        CDB_Q <= "11111"; --(others => '1');
        OpCode <= (others => '1');
        stop   <='0';
        -- EDIT Add stimuli here
        wait for 15 ns;
        stop<='0';
        Grand_in_A <= '0';
        Vk <="00000000000000000000000000000001";
        Vj <="00000000000000000000000000000001";
        Qk <="11111";
        Qj <="11111";
        CDB_V <="10000000000000000000000000000001"; 
        CDB_Q <= "11111";
        OpCode <= "00100";
        wait for 10 ns;
        
        stop<='1';
        wait for 30 ns;
        Grand_in_A <= '1';
        CDB_Q <= "01001";
        CDB_V <="00000000000000000000000000000010";
        wait for 10 ns;
        Grand_in_A <= '0';
        -- Stop the clock and hence terminate the simulation
 
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_MC_RS_FU_A of tb_MC_RS_FU_A is
    for tb
    end for;
end cfg_tb_MC_RS_FU_A;