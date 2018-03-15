library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signext is
  generic(bits : integer := 31);
  port(
        y  :out std_logic_vector( bits downto 0);
        a  :in  std_logic_vector( 15 downto 0)
      );
end entity;

architecture behavior of signext is
  begin
    y(14 downto 0) <= a(14 downto 0);
    gen:
    for i in 15 to 31 generate
      y(i) <= a(15);
  end generate; 
end architecture;
    
