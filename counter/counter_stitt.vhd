-- TAKEAWAY POINTS:
-- My recommendation is to only use integer types for constants or literals.
-- If you do use them for signals/variables, then the range should be
-- constrained. Even then, constrained integers frequently cause simulation
-- errors. 


-- The following counter entity shows another basic sequential logic example,
-- but compares the usage of the integer type and unsigned type. For this
-- particular example, unsigned is clearly the better choice.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter4bit is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        up     : in  std_logic;
        output : out std_logic_vector(3 downto 0));
end counter4bit;

-- The following architecture show a correct implementation of the counter when
-- using integers

architecture BHV_INT_GOOD of counter4bit is
    signal count_r : integer range 0 to 15;
    
begin
    process(clk, rst)
    begin
        if (rst = '1') then
            count_r <= 0;
        elsif (rising_edge(clk)) then
            if (up = '1') then

                -- Instead of using a variable to check for overflow, we can
                -- simply check to see if count is already at the max value. If
                -- so, set it to 0 instead of adding 1.
                
                if (count_r = 15) then
                    count_r <= 0;
                else
                    count_r <= count_r + 1;
                end if;
            else
                -- Similarly, if we are counting down and count = 0, set the
                -- count to 15 insted of subtracting 1.
                
                if (count_r = 0) then
                    count_r <= 15;
                else
                    count_r <= count_r - 1;
                end if;
            end if;
        end if;
    end process;

    output <= std_logic_vector(to_unsigned(count_r, 4));
    
end BHV_INT_GOOD;