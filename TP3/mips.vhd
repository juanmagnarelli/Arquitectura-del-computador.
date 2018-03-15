library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips is
  port(
       reset : in   std_logic;
       clk   : in   std_logic;
       dump  : in  std_logic;
       instr : out  std_logic_vector(31 downto 0);
       pc    : out  std_logic_vector(31 downto 0)
  );
end entity;

architecture behav of mips is
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

  component datapath is
    port(
        MemToReg,
        MemWrite,
        Branch,
        AluSrc,
        RegDst,
        RegWrite,
        Jump,
        Dump,
        reset,
        clk        : in std_logic;
        AluControl : in std_logic_vector(2 downto 0);
        pc, instr  : out std_logic_vector(31 downto 0)
    );
  end component;

  signal Instr_p, Pc_p     : std_logic_vector(31 downto 0);
  signal MemToReg_p, MemWrite_p, Branch_p, AluSrc_p, RegDst_p, RegWrite_p,
         Jump_p       : std_logic;
  signal AluControl_p : std_logic_vector(2 downto 0);

  begin
    controller_0 : controller port map(Op=>Instr_p(31 downto 26),
               funct=>Instr_p(5 downto 0), memtoreg=>MemToReg_p, memwrite=>MemWrite_p,
               branch=>Branch_p, alusrc=>AluSrc_p, regdst=>RegDst_p, regwrite=>RegWrite_p,
               jump=>Jump_p, alucontrol=>AluControl_p);
    datapath_0  : datapath port map(MemToReg=>MemToReg_p, MemWrite=>MemWrite_p,
             Branch=>Branch_p, AluSrc=>AluSrc_p, RegDst=>RegDst_p, RegWrite=>RegWrite_p,
             Jump=>Jump_p, AluControl=>AluControl_p, reset=>reset, clk=>clk,
             dump=>dump, pc=>Pc_p, instr=>Instr_p);
    instr <= Instr_p;
    pc <= Pc_p;
end architecture;
