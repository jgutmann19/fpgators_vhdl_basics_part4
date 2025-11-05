library ieee;
use ieee.std_logic_1164.all;

entity flip_flop is
    port(
        clk : in std_logic;
        rst : in std_logic;
        din : in std_logic;
        dout : out std_logic
    );
end flip_flop;

architecture ff of flip_flop is

    begin

        process(clk, rst) 
        begin
            -- if rst
            -- elsif (rising clk edge)

            -- active high rst
            if (rst = '1') then
                dout <= '0';
            elsif (rising_edge(clk)) then
                dout <= din;
            end if;

        end process;

end ff;