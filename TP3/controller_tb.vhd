library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_tb is
end entity;

architecture behav of controller_tb is
  component controller is
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
  end component;

  signal Op_p, funct_p : std_logic_vector(5 downto 0);
  signal memtoreg_p, memwrite_p, branch_p, alusrc_p, regdst_p, regwrite_p, jump_p : std_logic;
  signal alucontrol_p : std_logic_vector(2 downto 0);

  begin

  controller_0: controller port map (Op=>Op_p, funct=>funct_p, memtoreg=>memtoreg_p, memwrite=>memwrite_p,
                branch=>branch_p, alusrc=>alusrc_p, regdst=>regdst_p, regwrite=>regwrite_p, jump=>jump_p,
                alucontrol=>alucontrol_p);

  process
  begin
      Op_p <= "000100";
      funct_p <= "100000";
      wait for 5 ns;
  end process;
end;