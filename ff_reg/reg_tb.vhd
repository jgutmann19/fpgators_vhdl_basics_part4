library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity reg_tb is
end reg_tb;

architecture tb of reg_tb is
    constant WIDTH  : positive := 8;

    signal clk                           : std_logic := '0';
    signal rst                           : std_logic;
    signal input, output                 : std_logic_vector(WIDTH-1 downto 0);
begin
    DUT : entity work.reg_sync_rst -- change entity here!
        generic map (
            WIDTH  => WIDTH)
        port map (
            clk    => clk,
            rst    => rst,
            input  => input,
            output => output
            );
    
    clk <= not clk after 5 ns;

    process
    begin
        -- Reset the register
        rst   <= '1';
        input <= (others => '0');

        wait until rising_edge(clk);

        -- Clear the register for one cycle.
        rst <= '0';
        wait until rising_edge(clk);

        input <= std_logic_vector(to_unsigned(integer(2), WIDTH));

        wait until rising_edge(clk);

        wait for 1 ns;

        rst   <= '1';

        wait until rising_edge(clk);

        wait for 1 ns;

        rst   <= '0';

        wait;
    end process;
end architecture;