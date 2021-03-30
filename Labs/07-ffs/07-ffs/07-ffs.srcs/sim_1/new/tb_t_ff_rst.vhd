library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_t_ff_rst is
--  Port ( );
end tb_t_ff_rst;

architecture Behavioral of tb_t_ff_rst is

-- Local constants
     constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
     signal s_clk_100MHz  : std_logic;
     signal s_rst         : std_logic;  
     signal s_q           : std_logic;  
     signal s_q_bar       : std_logic;  
     signal s_t           : std_logic;
     

  begin
     uut_t_ff_rst : entity work.t_ff_rst
      port map (
         clk       => s_clk_100MHz,
         t         => s_t,
         rst       => s_rst,
         q         => s_q,
         q_bar     => s_q_bar
);

    
  p_clk_gen : process
     begin
        while now < 750 ns loop
            s_clk_100MHZ <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHZ <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
       end loop;
       wait; 
    end process p_clk_gen;

--------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------

     p_reset_gen : process
        begin
            s_rst <= '0';
            wait for 60 ns;
            
            -- Reset activated
            s_rst <= '1';
            wait for 15 ns;
    
            --Reset deactivated
            s_rst <= '0';
            
            --wait for 17 ns;
               
            wait;
     end process p_reset_gen;

p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        assert ((s_rst = '0') and (s_t = '0') and (s_q = '0') and (s_q_bar = '1'))
	    report "Test 'no change' failed for reset low, after clk rising when s_t = '0'" severity error;
          --d sequence 
        wait for 15ns;
        s_t  <= '0';
        s_q  <= '0';
        wait for 20ns;
        s_t  <= '0';
        s_q  <= '1';
        wait for 20ns;
        s_t  <= '1';
        s_q  <= '0';
        wait for 20ns;
        s_t  <= '1';
        s_q  <= '1';
        
        wait for 10ns;
        s_t  <= '1';
        s_q  <= '1';
        wait for 10ns;
        s_t  <= '1';
        s_q  <= '1';
        wait for 10ns;
        --d sequence
               
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end Behavioral;