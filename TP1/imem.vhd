library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imem is
  generic ( bits : integer := 32);
    port(
          a             :in  std_logic_vector( 5 downto 0);
          s             :out std_logic_vector( bits-1 downto 0)
        );
end entity;

architecture behav of imem is
  type rom is array (63 downto 0) of std_logic_vector(bits-1 downto 0);
  constant r : rom := (0 => "00000000000000000000000000000000",
                       1 => "00000000000000000000000000000001",
                       2 => "00000000000000000000000000000010",
                       3 => "00000000000000000000000000000011",
                       others => "00000000000000000000000000000000");
  begin
  s <= r(to_integer(unsigned(a)));

end architecture;

      
