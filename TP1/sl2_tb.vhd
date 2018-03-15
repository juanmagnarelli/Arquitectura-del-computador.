library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sl2_tb is
end entity;

architecture TB of sl2_tb is
    constant width : integer := 32;
component sl2 is
        port (
              y      :out std_logic_vector( width-1 downto 0);
              a      :in  std_logic_vector( width-1 downto 0)
              );
end component;

signal a_prima, y_prima: std_logic_vector( width-1 downto 0);

begin
   sl2_0: sl2 port map (a=>a_prima, y=>y_prima);

    process
    begin
    a_prima <= "00000000001000000010001111001111";

    wait for 1 ns;

    assert y_prima = "00000000100000001000111100111100"
        report "resultado erroneo" severity error;
    assert false report "test finalizado" severity note;
    end process;
 end;    
