library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dmem_tb is
end entity;

architecture TB of dmem_tb is
    constant bits : integer := 32;
component dmem is
    port(
          a             : in  std_logic_vector( bits-1 downto 0);
          wd            : in  std_logic_vector( bits-1 downto 0);
          clk           : in  std_logic;
          we            : in  std_logic;
          rd            : out std_logic_vector( bits-1 downto 0)
        );
end component;

signal a_prima, wd_prima, rd_prima : std_logic_vector( bits-1 downto 0);
signal clk_prima, we_prima  :  std_logic;

begin

dmem_0: dmem port map (a=>a_prima, wd=>wd_prima, rd=>rd_prima, clk=>clk_prima, we=>we_prima);

process
begin
    clk_prima <= '0';
    wait for 100 fs;
    clk_prima <= '1';
    wait for 100 fs;
end process;

process
begin

    a_prima <= "00000000000000000000000011110001";
    wd_prima <= "00000000000000000000000000000001";
    we_prima <= '0';
    
    wait for 200 fs;
    a_prima <= "00000000000000000000000011110111";
    wd_prima <= "00000000000000000000000000000111";
    we_prima <= '0';

    wait for 200 fs;

end process;
end;    
