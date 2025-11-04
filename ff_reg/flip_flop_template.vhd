library IEEE;
use IEEE.std_logic_1164.all;

entity DFlipFlop is
  Port (
    clk   : in  std_logic;
    d     : in  std_logic;
    q     : out std_logic;
    reset : in  std_logic
  );
end DFlipFlop;

architecture rtl of DFlipFlop is
begin
  process(clk, reset)
  begin
    if reset = '1' then
      q <= '0';
    elsif rising_edge(clk) then
      q <= d;
    end if;
  end process;
end rtl;