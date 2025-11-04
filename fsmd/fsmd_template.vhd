library ieee;
use ieee.std_logic_1164.all;

entity fsmd_template is
    port(
        clk : in std_logic;
        rst : in std_logic;
        en : in std_logic;
        output : out std_logic_vector(3 downto 0)
    );
end fsmd_template;

architecture moore of fsmd_template is

    -- Like the FSM, we define the states using a custom type.
    type state_t is (STATE0, STATE1, STATE2, STATE3);

    -- We are only using one process, so we just need the state_r signal.
    signal state_r : state_t;

begin

    process(clk,rst)
    begin
        if (rst = '1') then
            output <= "0001";
            state_r <= STATE0;
        elsif (rising_edge(clk)) then
            case (state_r) is
                when STATE0 =>
                    output <= "0001";
                    if (en = '1') then
                        state_r <= STATE1;
                    end if;

                when STATE1 =>
                    output <= "0010";
                    if (en = '1') then
                        state_r <= STATE2;
                    end if;

                when STATE2 =>
                    output <= "0100";
                    if (en = '1') then
                        state_r <= STATE3;
                    end if;

                when STATE3 =>
                    output <= "1000";
                    if (en = '1') then
                        state_r <= STATE0;
                    end if;
            end case;

        end if;
    end process;
    
end architecture;
