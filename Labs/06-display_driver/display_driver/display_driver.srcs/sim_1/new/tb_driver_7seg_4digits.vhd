library ieee;
use ieee.std_logic_1164.all;
entity tb_driver_7seg_4digits is
end entity tb_driver_7seg_4digits;

architecture testbench of tb_driver_7seg_4digits is

    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    signal s_clk_100MHz          : std_logic;
    signal s_reset               : std_logic;
    
    signal s_data0               : std_logic_vector(4-1 downto 0); 
    signal s_data1               : std_logic_vector(4-1 downto 0); 
    signal s_data2               : std_logic_vector(4-1 downto 0); 
    signal s_data3               : std_logic_vector(4-1 downto 0); 
       
    signal s_dp_i                : std_logic_vector(4-1 downto 0); 
    signal s_dp_o                : std_logic; 
    signal s_seg                 : std_logic_vector(7-1 downto 0); 
    
    signal s_dig                 : std_logic_vector(4-1 downto 0); 
    
begin
    -- Connecting testbench signals with driver_7seg_4digits entity
    -- (Unit Under Test)
    --- WRITE YOUR CODE HERE
    uut_driver_7seg_4digits : entity work.driver_7seg_4digits
    port map( 
        clk      => s_clk_100MHz,
        reset    => s_reset,
 
        data0_i  => s_data0,
        data1_i  => s_data1,
        data2_i  => s_data2,
        data3_i  => s_data3,

        dp_i     => s_dp_i,

        dp_o     => s_dp_o,

        seg_o    => s_seg,

        dig_o    => s_dig
        );

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop        
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    --- WRITE YOUR CODE HERE
    p_reset_gen : process
    begin
        s_reset  <= '0';
        wait for 28 ns;
        s_reset  <= '1';
        wait for 53 ns;
        s_reset <= '0';
        wait;
    end process p_reset_gen;

    --------------------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------------------
    --- WRITE YOUR CODE HERE
    p_stimulus : process
    begin
       report "Stimulus process started" severity note;
       s_data3  <= "0011";
       s_data2  <= "0001";
       s_data1  <= "0100";
       s_data0  <= "0010";
       
       s_dp_i   <= "0111";
       
       wait for 350 ns;
       
       
       report "Stimulus process finished" severity note;
       wait;
       end process p_stimulus;

end architecture testbench;
