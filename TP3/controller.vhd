library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
    port(
          Op         : in  std_logic_vector(5 downto 0);
          funct      : in  std_logic_vector(5 downto 0);
          memtoreg   : out  std_logic;
          memwrite   : out  std_logic; 
          branch     : out  std_logic; 
          alusrc     : out  std_logic; 
          regdst     : out  std_logic; 
          regwrite   : out  std_logic; 
          jump       : out  std_logic; 
          alucontrol : out  std_logic_vector(2 downto 0)
          
        );
end entity;

architecture behav of controller is
  component maindec is
    port(
      Op       : in   std_logic_vector(5 downto 0);
      Memtoreg : out  std_logic;
      Memwrite : out  std_logic; 
      Branch   : out  std_logic; 
      Alusrc   : out  std_logic; 
      Regdst   : out  std_logic; 
      Regwrite : out  std_logic; 
      Jump     : out  std_logic; 
      Aluop    : out  std_logic_vector( 1 downto 0)
    );
  end component;

  component aludec is
    port(
      funct      : in  std_logic_vector( 5 downto 0);
      aluop      : in  std_logic_vector( 1 downto 0);
      alucontrol : out  std_logic_vector( 2 downto 0)
    );
  end component;

  signal aluop_aux : std_logic_vector(1 downto 0);

  begin   
  
  maindec_0 : maindec port map(Aluop=>aluop_aux,  Op=>Op, memtoreg=>memtoreg, 
                        memwrite=>memwrite, branch=>branch, alusrc=>alusrc,
                        regdst=>regdst, regwrite=>regwrite, jump=>jump);
  aludec_0 : aludec port map(aluop=>aluop_aux, funct=>funct, alucontrol=>alucontrol);

end architecture;