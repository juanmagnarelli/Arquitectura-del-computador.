library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maindec is
    port(
          op       : in   std_logic_vector(5 downto 0);
          memtoreg : out  std_logic;
          memwrite : out  std_logic; 
          branch   : out  std_logic; 
          alusrc   : out  std_logic; 
          regdst   : out  std_logic; 
          regwrite : out  std_logic; 
          jump     : out  std_logic; 
          aluop    : out  std_logic_vector( 1 downto 0)
        );
end entity;

architecture behav of maindec is
  begin
    process(op)
    begin
      case op is
        when "000000" =>
          regwrite <= '1'; 
          regdst   <= '1'; 
          alusrc   <= '0'; 
          branch   <= '0'; 
          memwrite <= '0'; 
          memtoreg <= '0';
          jump     <= '0'; 
          aluop    <= "10";
        when "100011" => 
          regwrite <= '1'; 
          regdst   <= '0'; 
          alusrc   <= '1'; 
          branch   <= '0'; 
          memwrite <= '0'; 
          memtoreg <= '1';
          jump     <= '0'; 
          aluop    <= "00";
        when "101011" => 
          regwrite <= '0'; 
          regdst   <= '0'; 
          alusrc   <= '1'; 
          branch   <= '0'; 
          memwrite <= '1'; 
          memtoreg <= '0';
          jump     <= '0'; 
          aluop    <= "00";
        when "000100" =>
          regwrite <= '0'; 
          regdst   <= '0'; 
          alusrc   <= '0'; 
          branch   <= '1'; 
          memwrite <= '0'; 
          memtoreg <= '0';
          jump     <= '0'; 
          aluop    <= "01";
        when "001000" =>
          regwrite <= '1'; 
          regdst   <= '0'; 
          alusrc   <= '1'; 
          branch   <= '0'; 
          memwrite <= '0'; 
          memtoreg <= '0';
          jump     <= '0'; 
          aluop    <= "00";
        when "000010" =>
          regwrite <= '0'; 
          regdst   <= '0'; 
          alusrc   <= '0'; 
          branch   <= '0'; 
          memwrite <= '0'; 
          memtoreg <= '0';
          jump     <= '1'; 
          aluop    <= "00";  
        when others => null;
      end case;
    end process;
end architecture;

      
