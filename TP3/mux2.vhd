library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2 is
	generic (NBITS : natural := 31);

    port(   d0: in std_logic_vector(NBITS downto 0);
            d1: in std_logic_vector(NBITS downto 0);
            s: in std_logic;
            y: out std_logic_vector(NBITS downto 0)
       );
end entity;
  
architecture behav of mux2 is
    begin
        y <= d0 when (s = '0') else
        	 d1 when (s = '1') else
        	 unaffected;
end behav;
