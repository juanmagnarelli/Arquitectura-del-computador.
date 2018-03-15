library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maindec_tb is
end entity;

architecture TB of maindec_tb is
  component maindec is
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
  end component;

  signal op_p : std_logic_vector(5 downto 0);
  signal memtoreg_p, memwrite_p, branch_p, alusrc_p, regdst_p, regwrite_p, jump_p : std_logic;
  signal aluop_p : std_logic_vector(1 downto 0);

  begin

  maindec_0 : maindec port map 
          (op=>op_p, memtoreg=>memtoreg_p, memwrite=>memwrite_p, branch=>branch_p, 
           alusrc=>alusrc_p, regdst=>regdst_p, regwrite=>regwrite_p, jump=>jump_p,
           aluop=>aluop_p);
  process
  begin
    
    op_p <= "000000";
    wait for 5 ns;

    assert regwrite_p = '1' and regdst_p = '1' and aluop_p = "10"
        report "Resultado erroneo" severity error;
    assert false report "Test end" severity note;
  end process;
end;    
