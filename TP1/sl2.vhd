library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sl2 is
    port(   a: in  std_logic_vector(31 downto 0);
            y: out std_logic_vector(31 downto 0));
end entity;
  
architecture behav of sl2 is
    begin
       y <= std_logic_vector(unsigned(a) * 4);
end behav;