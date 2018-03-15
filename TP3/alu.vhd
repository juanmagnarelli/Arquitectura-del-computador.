library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
  generic ( bits : integer := 32);
    port(
          a             :in  std_logic_vector( bits-1 downto 0);
          b             :in  std_logic_vector( bits-1 downto 0);
          alucontrol    :in  std_logic_vector( 2 downto 0);
          result        :out std_logic_vector( bits-1 downto 0);
          zero          :out std_logic
        );
end entity;

architecture behavior of alu is
  signal res_tem : std_logic_vector(bits-1 downto 0);
  begin
    process(a, b, alucontrol)
    begin
      case alucontrol is
        when "000" => res_tem <= (a and b);
        when "001" => res_tem <= (a or b);
        when "010" => res_tem <= (std_logic_vector(unsigned(a) + unsigned(b)));
        when "100" => res_tem <= (a and (not b));
        when "101" => res_tem <= (a or (not b));
        when "110" => res_tem <= (std_logic_vector(unsigned(a) - unsigned(b)));
        when "111" =>
          if a < b then res_tem <= "00000000000000000000000000000001";
          else res_tem <= "00000000000000000000000000000000";
          end if;
        when others => null;
      end case;
    end process;
    process(res_tem)
    begin  
      if res_tem = "00000000000000000000000000000000" then zero <= '1';
      else zero <= '0';
      end if;
      result <= res_tem;
    end process;
end architecture;
