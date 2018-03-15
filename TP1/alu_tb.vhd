library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity;

architecture TB of alu_tb is
    constant width : integer := 32;
component alu is
        port (
              a             :in  std_logic_vector( width-1 downto 0);
              b             :in  std_logic_vector( width-1 downto 0);
              alucontrol    :in  std_logic_vector( 2 downto 0);
              result        :out std_logic_vector( width-1 downto 0);
              zero          :out std_logic
              );
end component;

signal a_prima, b_prima, result_prima : std_logic_vector( width-1 downto 0);
signal alucontrol_prima : std_logic_vector( 2 downto 0);
signal zero_prima : std_logic;

begin

alu_0: alu port map (a=>a_prima, b=>b_prima, alucontrol=>alucontrol_prima,result=>result_prima, zero=>zero_prima);
  process
  begin
    
    a_prima <= "00000000000000000000000000000001";
    b_prima <= "00000000000000000000000000000000";
    alucontrol_prima <= "000";

    wait for 5 ns;
    end process;
 end;    
