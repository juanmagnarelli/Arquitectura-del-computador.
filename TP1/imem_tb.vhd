library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imem_tb is
end entity;

architecture TB of imem_tb is
    constant width : integer := 32;
component imem is
    port(
          a             :in  std_logic_vector( 5 downto 0);
          s             :out  std_logic_vector( width-1 downto 0)
        );
end component;

signal a_prima : std_logic_vector( 5 downto 0);
signal s_prima : std_logic_vector( width-1 downto 0);

begin

imem_0: imem port map (a=>a_prima, s=>s_prima);
  process
  begin
    
    a_prima <= "000001";
    wait for 5 ns;

   end process;
 end;    
