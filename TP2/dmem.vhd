library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dmem is
  generic ( bits : integer := 32);
    port(
          a             : in  std_logic_vector( bits downto 0);
          wd            : in  std_logic_vector( bits downto 0);
          clk           : in  std_logic;
          we            : in  std_logic;
          rd            : out std_logic_vector( bits-1 downto 0)
        );
end entity;

architecture behav of dmem is
  type ram is array (63 downto 0) of std_logic_vector(bits-1 downto 0);
  signal r : ram;
  begin
    process(a, wd, clk)
    begin
      if clk'event and clk = '1' then
        if we = '1' then
          r(to_integer(unsigned(a(7 downto 2)))) <= wd;
        elsif we = '0' then
          rd <= r(to_integer(unsigned(a(7 downto 2))));
        end if;
      else
        null;
      end if;
    end process;
end architecture;