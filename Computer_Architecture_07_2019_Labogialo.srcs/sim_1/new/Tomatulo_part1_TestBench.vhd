----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2018 03:14:17 PM
-- Design Name: 
-- Module Name: Tomatulo_part1_TestBench - Behavioral
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

entity tb_Tomatulo is
end tb_Tomatulo;

architecture tb of tb_Tomatulo is

    component Tomatulo
        port (CLK      : in std_logic;
              reset      : in std_logic;
              Accepted : out std_logic;
              Fu_type  : in std_logic_vector (1 downto 0);
              FOp      : in std_logic_vector (1 downto 0);
              R_dest   : in std_logic_vector (4 downto 0);
              Rk_addr  : in std_logic_vector (4 downto 0);
              Rj_addr  : in std_logic_vector (4 downto 0);
              Issue_in : in std_logic);
    end component;

    signal CLK      : std_logic;
    signal reset      : std_logic;
    signal Accepted : std_logic;
    signal Fu_type  : std_logic_vector (1 downto 0);
    signal FOp      : std_logic_vector (1 downto 0);
    signal R_dest   : std_logic_vector (4 downto 0);
    signal Rk_addr  : std_logic_vector (4 downto 0);
    signal Rj_addr  : std_logic_vector (4 downto 0);
    signal Issue_in : std_logic;

    constant CLK_period : time := 10 ns; 
begin

    dut : Tomatulo
    port map (CLK      => CLK,
                reset =>reset,
              Accepted => Accepted,
              Fu_type  => Fu_type,
              FOp      => FOp,
              R_dest   => R_dest,
              Rk_addr  => Rk_addr,
              Rj_addr  => Rj_addr,
              Issue_in => Issue_in);

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
        Fu_type <= (others => '0');
        FOp <= (others => '0');
        R_dest <= (others => '0');
        Rk_addr <= (others => '0');
        Rj_addr <= (others => '0');
        Issue_in <= '0';
        
        reset<='1';
        
        -- bazoume, r1<=r0+r2 = 1 ,r2<= r1+r2=2(ekdidetai otan to R1 bgei ston CDB) , r3<=r3+r2=3, r4<=r2+r2=4, r5<=r5+r4=5  
        wait for 15 ns;
        reset<='0';
        Issue_in <= '1';
        
        Fu_type <= "01";  --  gia arithmitikh pra3h
        Fop <= "00";  --- gia prosthesh       
        R_dest <= "00001";      
        Rk_addr <= "00000";
        Rj_addr <= "00010";
       
        wait for 10 ns;
       
        
        Issue_in <= '1';
        Fu_type <= "01";  --  gia arithmitikh pra3h
        Fop <= "00";  --- gia prosthesh       
        R_dest <= "00010";      
        Rk_addr <= "00001";  -- gia na exoume e3arthsh apo to prohgoumeno
        Rj_addr <= "00010";
        
        wait for 10 ns;
        
                
        Fu_type <= "01";  --  gia arithmitikh pra3h
        Fop <= "00";  --- gia prosthesh       
        R_dest <= "00011";      
        Rk_addr <= "00010";  -- gia na exoume e3arthsh apo to prohgoumeno
        Rj_addr <= "00011";
        wait for 10 ns;      
        Issue_in <= '1'; 
        

         Issue_in <= '1';               
        Fu_type <= "01";  --  gia arithmitikh pra3h
        Fop <= "00";  --- gia prosthesh       
        R_dest <= "00100";      
        Rk_addr <= "00010";  -- gia na exoume e3arthsh apo to prohgoumeno
        Rj_addr <= "00010";
        wait for 30 ns;
    -- Issue_in <= '0'; 
                      
        Fu_type <= "01";  --  gia arithmitikh pra3h
        Fop <= "00";  --- gia prosthesh       
        R_dest <= "00101";      
        Rk_addr <= "00100";  -- gia na exoume e3arthsh apo to prohgoumeno
        Rj_addr <= "00101";        
        
        wait for 40 ns;
        Issue_in <= '0';
        --wait for 140 ns;
        ----------------------------------------------------------------------------------extend
        
--        ----- kateutheian apo to arxiko
--        -----bazoume , r6<=r5 or R2 =7 , R7<=R6 OR R3 =7 , R8<= NOT R6 = ?                                            
--        Fu_type <= "00";  --  gia logikh pra3h                                                                                    
--        Fop <=     "00";  ---                                                                                                     
--        R_dest  <= "00110";                                                                                                       
--        Rk_addr <= "00101";  -- gia na exoume e3arthsh apo to prohgoumeno                                                         
--        Rj_addr <= "00010";                                                                                                       
                                                                                                                                  
--        wait for 10 ns;                                                                                                           
                                                                                                                                  
--        Fu_type <= "00";  --    gia logikh pra3h                                                                                  
--        Fop <=     "00";  ---                                                                                                     
--        R_dest <=  "00111";                                                                                                       
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno                                                         
--        Rj_addr <= "00011";                                                                                                       
                                                                                                                                  
--        wait for 10 ns;                                                                                                           
                                                                                                                                  
                                                                                                                                  
--        Fu_type <= "00";  --  gia logikh pra3h                                                                                    
--        Fop <= "10";  --                                                                                                          
--        R_dest <=  "01000";                                                                                                       
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno                                                         
--        Rj_addr <= "00110";                                                                                                       
                                                                                                                                  
                                                                                                                                  
--         wait for 90 ns;                                                                                                          
--         Issue_in <= '0';                                                                                                         
        
        
        
        
         
          
        
        
    
------------------------------------------------------------------------------------round-robin test
--          Issue_in <= '0';      
--        wait for 90 ns;
--         --bazoume r6<=r6+r6=2, r1<=r6-r2=0 , r8<=r6-r7=1
--        Issue_in <= '1'; 
--        Fu_type <= "01";  --  gia arithmitikh pra3h
--        Fop <= "00";  --- gia prosthesh       
--        R_dest <=  "00110";      
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00110";

--        wait for 10 ns;


--        Fu_type <= "01";  --  gia arithmitikh pra3h
--        Fop <= "01";  --- gia afairesh       
--        R_dest <=  "00001";      
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00010";

--        wait for 10 ns;

    


--        Fu_type <= "01";  --  gia arithmitikh pra3h
--        Fop <= "01";  --- gia afairesh       
--        R_dest <=  "01000";      
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00111";
        
--        wait for 10 ns;
--        Issue_in <= '0';
--        wait for 20 ns;   
--       Issue_in <= '1';
--------------------
    
----         --   bazoume , r5<=r5 or R2 =7 , R7<=R4 OR R3 = 7 , R8<= NOT R4 = ?
--           Fu_type <= "00";  --  gia logikh pra3h
--           Fop <=     "00";  ---     
--           R_dest  <= "00101";      
--           Rk_addr <= "00101";  -- gia na exoume e3arthsh apo to prohgoumeno
--           Rj_addr <= "00010";
           
--           wait for 10 ns;
           
--           Fu_type <= "00";  --    gia logikh pra3h
--           Fop <=     "00";  ---      
--           R_dest <=  "00111";      
--           Rk_addr <= "00100";  -- gia na exoume e3arthsh apo to prohgoumeno
--           Rj_addr <= "00011";
--           wait for 10 ns;
--           Issue_in <= '0';

-----------------------------------------------------------------------------------       
 
 
 ----------------------------------------------------------------       
--        --bazoume r6<=r6+r6=2(arithmitiko), r1<=r6 OR r2 = 2 (logiko)                  ------e3arthseis meta3u monadwn
--        wait for 90 ns;
--        Issue_in <= '1'; 
--        Fu_type <= "01";  --  gia arithmitikh pra3h
--        Fop <= "00";  --- gia prosthesh       
--        R_dest <=  "00110";      
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00110";
        
--        wait for 10 ns;
        
--        Fu_type <= "00";  --  gia logikh pra3h
--        Fop <= "00";  --- OR       
--        R_dest <=  "00001";      
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00010";
         
--        wait for 10 ns;
--        Issue_in <= '0';
---------------------------------------------------------------------       
--        wait for 40 ns;
--        Issue_in <= '1';
        
--        ----balame  ,r1<=r4-r2=2 , r1<=r0+r5=5, r5<=r1+r5=10
--        Fu_type <= "01";  --  gia arithmitikh pra3h
--        Fop <= "01";  --- gia afairesh       
--        R_dest <=  "00001";      
--        Rk_addr <= "00100";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00010";    
--        wait for 10 ns;
--        Fu_type <= "01";  --  gia arithmitikh pra3h
--        Fop <= "00";  ---      
--        R_dest <=  "00001";      
--        Rk_addr <= "00000";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00101"; 
--        wait for 10 ns;  
--        Fu_type <= "01";  --  gia arithmitikh pra3h
--        Fop <= "00";  ---      
--        R_dest <=  "00101";      
--        Rk_addr <= "00001";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00101"; 
--        wait for 20 ns;

--        Issue_in <= '0';
-------------------------------------------------------------------------------
--        -- --bazoume , r6<=r6 and r6 = 1 , r1<= r5 or r2 = 7, r2<= r5 AND r7= 1
       
--         Issue_in <= '1';
         
--        Fu_type <= "00";  --  gia logikh pra3h
--        Fop <=     "01";  ---     
--        R_dest  <= "00110";      
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00110";
        
--        wait for 10 ns;
        
--        Fu_type <= "00";  --  gia logikh pra3h
--        Fop <= "00";  ---      
--        R_dest <=  "00001";      
--        Rk_addr <= "00101";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00010";
        
--        wait for 10 ns;
        
        
--        Fu_type <= "00";  --  gia logikh pra3h
--        Fop <= "01";  --   
--        R_dest <=  "00010";      
--        Rk_addr <= "00101";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00111";
                         
--         wait for 40 ns;
--         Issue_in <= '0';
 --------------------------------------------------------------------------------------
--         Issue_in <= '1';
   
--   --   bazoume , r6<=r5 or R2 =7 , R7<=R6 OR R3 =7 , R8<= NOT R6 = ?
--        Fu_type <= "00";  --  gia logikh pra3h
--        Fop <=     "00";  ---     
--        R_dest  <= "00110";      
--        Rk_addr <= "00101";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00010";
        
--        wait for 10 ns;
        
--        Fu_type <= "00";  --    gia logikh pra3h
--        Fop <=     "00";  ---      
--        R_dest <=  "00111";      
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00011";
        
--        wait for 10 ns;
        
        
--        Fu_type <= "00";  --  gia logikh pra3h
--        Fop <= "10";  --   
--        R_dest <=  "01000";      
--        Rk_addr <= "00110";  -- gia na exoume e3arthsh apo to prohgoumeno
--        Rj_addr <= "00110";
 
 
--         wait for 30 ns;         
--         Issue_in <= '0';
        
        

--        if(accepted='1') then ---- to if rwtaei panta gia accepted, to perioxoume tou then tha allazei sumfwna me emas,exoume/den exoume entolh
--            Issue_in <= '1';
--            ---------------nea entolh-------------
--            --------------------------------------
--        else
--            wait for 10ns;
--        end if;
        wait;

        -- EDIT Add stimuli here
      

        -- Stop the clock and hence terminate the simulation
   
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Tomatulo of tb_Tomatulo is
    for tb
    end for;
end cfg_tb_Tomatulo;