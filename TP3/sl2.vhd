library ieee;
use ieee.std_logic_1164.all;


entity sl2 is
generic(SHIFT: natural:=2);
port(
	a : in std_logic_vector(31 downto 0);
	y : out std_logic_vector(31 downto 0)
);
end entity;
architecture shift_1 of sl2 is
begin
process(a)
begin
	for i in 0 to 29 loop 
		y(i+2) <= a(i);
	end loop ;
	y(0) <= '0';
 	y(1) <= '0';
end process;
end architecture;