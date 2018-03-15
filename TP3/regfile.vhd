library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
    port(
          ra1  : in  std_logic_vector(4 downto 0);
          ra2  : in  std_logic_vector(4 downto 0);
          wa3  : in  std_logic_vector(4 downto 0);
          wd3  : in  std_logic_vector(31 downto 0);
          we3  : in  std_logic;
          clk  : in  std_logic;
          rd1  : out std_logic_vector(31 downto 0);
          rd2  : out std_logic_vector(31 downto 0)
        );
end entity;

architecture behav of regfile is
  type reg is array (31 downto 0) of std_logic_vector(31 downto 0);
  signal r : reg := (0 => "00000000000000000000000000000000",
                      others => "00000000000000000000000000000000");
  
  begin
    process(ra1, ra2, clk)
    begin
      if clk'event and clk = '1' then
        if we3 = '1' then
          r(to_integer(unsigned(wa3))) <= wd3;
          if ra1 = "00000" then rd1 <= "00000000000000000000000000000000";
          elsif ra2 = "00000" then rd2 <= "00000000000000000000000000000000";
          else
            rd1 <= r(to_integer(unsigned(ra1)));
            rd2 <= r(to_integer(unsigned(ra2)));
          end if;
        elsif we3 = '0' then
          rd1 <= r(to_integer(unsigned(ra1)));
          rd2 <= r(to_integer(unsigned(ra2)));
        end if;
      else
        null;
      end if;
    end process;
end architecture;
