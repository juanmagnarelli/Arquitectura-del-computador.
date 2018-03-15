library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_tb is
end entity;

architecture TB of adder_tb is
    constant width : integer := 32;

component adder is
    port (
          y     :out std_logic_vector( width-1 downto 0);
          a     :in  std_logic_vector( width-1 downto 0);
          b     :in  std_logic_vector( width-1 downto 0)
         );
    end component;

    for adder_0: adder use entity work.adder;
    signal a_prima, b_prima, y_prima: std_logic_vector( width-1 downto 0);

begin
   adder_0: adder port map (a=>a_prima, b=>b_prima, y=>y_prima);

    process
    begin

    a_prima <= "00000000000000000000000000000001";
    b_prima <= "00000000000000000000000000000001";
    wait for 1 ns;
    

    assert y_prima = std_logic_vector(to_unsigned (2, 32))
        report "resultado erroneo" severity error;
    assert false report "test finalizado" severity note;

    end process;
    end;

