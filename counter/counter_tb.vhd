library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity counter_tb is
end counter_tb;

architecture tb of counter_tb is
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal up     : std_logic := '1';
    signal output : std_logic_vector(3 downto 0);
begin
    -- Change the architecture to test the different implementations and
    -- different max_values
    DUT : entity work.counter4bit
        port map (
            clk    => clk,
            rst    => rst,
            up     => up,
            output => output);

    clk <= not clk after 5 ns;
    
    process
    begin
         -- Reset the counter
        rst <= '1';
        wait until rising_edge(clk);

        -- Clear reset
        rst <= '0';
        wait until rising_edge(clk);

        up <= '1';
        for i in 0 to 19 loop
            wait until rising_edge(clk);
        end loop;

        up <= '0';
        for i in 0 to 19 loop
            wait until rising_edge(clk);
        end loop;

        report "Tests completed.";
        wait;
        

    end process;

end architecture;