library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath_tb is
end entity;

architecture behav of datapath_tb is
  component datapath is
    port(
        MemToReg   : in  std_logic;
        MemWrite   : in  std_logic;
        Branch     : in  std_logic;
        AluSrc     : in  std_logic;
        RegDst     : in  std_logic;
        RegWrite   : in  std_logic;
        Jump       : in  std_logic;
        AluControl : in  std_logic_vector(2 downto 0);
        dump       : in  std_logic;
        reset      : in  std_logic;
        clk        : in  std_logic;
        pc         : out std_logic_vector(31 downto 0);
        instr      : out std_logic_vector(31 downto 0)
    );
  end component;

  signal pc_p, instr_p : std_logic_vector(31 downto 0);
  signal memtoreg_p, memwrite_p, branch_p, alusrc_p, regdst_p, regwrite_p, jump_p, dump_p, reset_p, clk_p: std_logic;
  signal alucontrol_p : std_logic_vector(2 downto 0);

  begin

  datapath_0: datapath port map (pc=>pc_p, instr=>instr_p, MemToReg=>memtoreg_p, MemWrite=>memwrite_p,
                Branch=>branch_p, AluSrc=>alusrc_p, RegDst=>regdst_p, RegWrite=>regwrite_p, Jump=>jump_p,
                AluControl=>alucontrol_p, reset=>reset_p, clk=>clk_p, dump=>dump_p);

  process
  begin
    clk_p <= '0';
    wait for 10 ns;
    clk_p <= '1';
    wait for 10 ns;
  end process;

  process
  begin
    reset_p <= '1';
    wait for 10 ns;
    reset_p <= '0';
    wait for 500 ns;
  end process;

  process
  begin
    MemToReg_p   <='0';
    MemWrite_p   <='0';
    Branch_p     <='0';
    AluSrc_p     <='0';
    RegDst_p     <='1';
    RegWrite_p   <='1';
    Jump_p       <='0';
    AluControl_p <="000";
    dump_p       <='0';
    wait for 10 ns;
  end process;
end;
