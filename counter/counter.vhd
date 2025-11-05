library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    port(
        clk : in std_logic;
        rst : in std_logic;
        up : in std_logic;
        output : out std_logic_vector(3 downto 0)
    );
end counter;

architecture count of counter is

    signal count_r : INTEGER;

    begin
        process(clk, rst)
        begin
            if (rst = '1') then
                count_r <= 0;
            elsif (rising_edge(clk)) then
                -- up is true so we want to count up, duhhh
                if (up = '1') then
                    if (count_r = 15) then
                        count_r <= 0;
                    else 
                        count_r <= count_r + 1;
                    end if;
                    
                -- we want to count down
                else
                    if (count_r = 0) then
                        count_r <= 15;
                    else
                        count_r <= count_r - 1;
                    end if;
                    
                end if;
            end if;
        end process;

        output <= std_logic_vector(to_unsigned(count_r, 4));
end count;