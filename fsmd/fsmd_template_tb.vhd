library ieee;
use ieee.std_logic_1164.all;

entity fsmd_template_tb is
end fsmd_template_tb;

architecture tb of fsmd_template_tb is
    signal clk    : std_logic := '0';
    signal rst    : std_logic := '0';
    signal en     : std_logic := '0';
    signal output : std_logic_vector(3 downto 0);
begin

    DUT : entity work.fsmd
        port map (
            clk    => clk,
            rst    => rst,
            en     => en,
            output => output);

    clk <= not clk after 5 ns;

    process
    begin
        -- Reset the counter
        rst <= '1';
        en <= '0';
        wait until rising_edge(clk);

        -- Clear reset
        rst <= '0';
        wait until rising_edge(clk);

        en <= '1';
        for i in 0 to 4 loop
            wait until rising_edge(clk);
        end loop;

        report "End of Loop.";
        wait;

    end process;
    

end architecture;