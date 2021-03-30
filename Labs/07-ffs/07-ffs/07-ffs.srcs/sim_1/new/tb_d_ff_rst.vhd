library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_d_ff_rst is
--  Port ( );
end tb_d_ff_rst;

architecture Behavioral of tb_d_ff_rst is

-- Local constants
     constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    

     signal s_clk_100MHz : std_logic;
     signal s_d          :  STD_LOGIC;  
     signal s_rst        :  STD_LOGIC;  
     signal s_q          :  STD_LOGIC; 
     signal s_q_bar      :  STD_LOGIC;

  begin
     uut_d_ff_rst : entity work.d_ff_rst
      port map (
         clk       => s_clk_100MHz,
         d         => s_d,
         rst       => s_rst,
         q         => s_q,
         q_bar     => s_q_bar
);

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    
     p_clk_gen : process
         begin
	           while now < 750 ms loop        
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

--------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        
          --d sequence 
        wait for 15ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        s_d  <= '1';
        wait for 10ns;
        s_d  <= '0';
        wait for 10ns;
        --d sequence
        assert ((s_rst = '1') and (s_q = '1') and (s_q_bar = '0'))
	    report "Test failed for reset high, before clk rising when s_d = '1'" severity error;
	
        
       
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end Behavioral;