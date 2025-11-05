library ieee;
use ieee.std_logic_1164.all;

entity reg is
    generic(
        WIDTH : positive
    );
    port(
        clk : in std_logic;
        rst : in std_logic;
        din : in std_logic_vector(WIDTH-1 downto 0);
        dout : out std_logic_vector(WIDTH-1 downto 0)
    );
end reg;

architecture regi of reg is

    begin

        process(clk, rst)
        begin
            if (rising_edge(clk)) then
                if (rst = '1') then
                    dout <= (others => '0'); -- SV: '0;
                else 
                    dout <= din;
                end if;
            end if;

        end process;

end regi;