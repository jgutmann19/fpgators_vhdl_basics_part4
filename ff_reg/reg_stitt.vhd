library ieee;
use ieee.std_logic_1164.all;

entity reg_async_rst is
    generic(
        WIDTH : positive
        );
    port(
        clk    : in  std_logic;
        rst    : in  std_logic;
        input  : in  std_logic_vector(WIDTH-1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0)
        );
end reg_async_rst;

architecture BHV of reg_async_rst is
begin
    -- GUIDELINE 1 FOR SEQUENTIAL LOGIC: The sensitivity list should
    -- only have clock and reset (if there is an asynchronous reset). It
    -- technically shouldn't hurt anything if you include other signals, but
    -- they are not necessary, can slow down a simulation by needlessly
    -- retriggering the process, and might confuse a bad synthesis tool.
    
    process(clk, rst)
    begin
        -- SYNTHESIS GUIDELINE 2 FOR SEQUENTIAL LOGIC: All sequential logic with
        -- async reset should be described using the following basic structure:
        --
        -- if reset
        --   handle reset 
        -- elsif rising clock edge
        --   specify all non-reset functionality
        -- end if

        
        if (rst = '1') then
            -- Reset the output to all 0s. The others statement sets all the
            -- bits equal to the specified value. It is part of a more general
            -- aggregation construct that will be discussed in other examples.
            output <= (others => '0');
            
        elsif (rising_edge(clk)) then

            -- SYNTHESIS RULE: Any assignment to a signal on a rising clock
            -- edge will be synthesized as a register, where the LHS is the
            -- output of the register, and the RHS is the input. This might
            -- seem obvious for this simple example, but it is critically
            -- important to remember this rule for bigger examples because
            -- adding or omitting a register is a very common source of bugs.
            -- When we "design the circuit" before writing the code, a huge
            -- part of that design is determining the number of registers.
            -- To ensure that the synthesized circuit has the same number of
            -- registers as our design circuit, we need to understand how
            -- registers get created during synthesis.
            --
            -- Note that variables can be synthesized as either wires or
            -- registers depending on the usage, which will be explained in
            -- later examples.
            output <= input;
        end if;
    end process;
end BHV;

library ieee;
use ieee.std_logic_1164.all;

-- Entity: reg_sync_rst
-- Description: Implements a register with an active high, synchronous reset.

entity reg_sync_rst is
    generic(
        WIDTH : positive
        );
    port(
        clk    : in  std_logic;
        rst    : in  std_logic;
        input  : in  std_logic_vector(WIDTH-1 downto 0);
        output : out std_logic_vector(WIDTH-1 downto 0)
        );
end reg_sync_rst;

architecture BHV of reg_sync_rst is
begin
    -- For a synchronous reset, we only need the clock in the sensitivity list.
    -- However, it doesn't really hurt to include reset because a simulation is
    -- unlikely to be frequently resetting a register, so it probably won't
    -- slow down the simulation much. Also, it won't affect synthesis. 
    process(clk)
    begin
        if (rising_edge(clk)) then
            -- For the synchronous reset, we check the reset on the rising
            -- clock edge.
            if (rst = '1') then
                output <= (others => '0');
            else
                output <= input;
            end if;
        end if;
    end process;
end BHV;