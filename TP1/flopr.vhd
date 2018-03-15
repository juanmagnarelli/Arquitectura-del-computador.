library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopr is
  generic (bits : integer := 32);
      port(
            d     : in std_logic_vector( bits-1 downto 0);
            reset : in  std_logic;
            clk   : in std_logic;
            q     : out std_logic_vector(bits-1 downto 0)
          );
end entity;

architecture behav of flopr is
  begin
    process(clk, reset)
    begin
      if reset = '1' then q <= '00000000000000000000000000000000';
      elsif clk'event and clk = '1' then q <= d;
      end if;
    end process;
end architecture;
    
