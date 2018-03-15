library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aludec is
    port(
          funct      : in  std_logic_vector( 5 downto 0);
          aluop      : in  std_logic_vector( 1 downto 0);
          alucontrol : out  std_logic_vector( 2 downto 0)
          
        );
end entity;

architecture behav of aludec is
  begin   
    process(aluop, funct)
    begin
      if aluop(1) = '0' then
        if aluop(0) = '0' then alucontrol <= "010";
        elsif aluop(0) = '1' then alucontrol <= "110";
        end if;
      else
        case funct is
          when "100000" => alucontrol <= "010";
          when "100010" => alucontrol <= "110";
          when "100100" => alucontrol <= "000";
          when "100101" => alucontrol <= "001";
          when "101010" => alucontrol <= "111";
          when others => null;
        end case;
      end if;
    end process;
end architecture;

      
