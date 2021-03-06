library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is
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
end entity;

architecture behav of datapath is
  component adder is
    port (
         a, b : in std_logic_vector(31 downto 0);
         y    : out std_logic_vector(31 downto 0)
    );
  end component;

  component flopr is
    port(
        d     : in std_logic_vector( 31 downto 0);
        reset : in  std_logic;
        clk   : in std_logic;
        q     : out std_logic_vector(31 downto 0)
    );
  end component;

  component mux2 is
    generic (NBITS : natural := 31);
    port(
        d0 : in std_logic_vector(NBITS downto 0);
        d1 : in std_logic_vector(NBITS downto 0);
        s  : in std_logic;
        y  : out std_logic_vector(NBITS downto 0)
    );
  end component;

  component imem is
    port(
         a  : in  std_logic_vector(5 downto 0);
         rd : out std_logic_vector(31 downto 0)
        );
  end component;

  component signext is
    port(
        a : in  std_logic_vector(15 downto 0);
        y : out std_logic_vector(31 downto 0)
    );
  end component;

  component sl2 is
    port(
         a : in  std_logic_vector(31 downto 0);
         y : out std_logic_vector(31 downto 0)
    );
  end component;

  component alu is
    port(
        a          : in  std_logic_vector(31 downto 0);
        b          : in  std_logic_vector(31 downto 0);
        alucontrol : in  std_logic_vector(2 downto 0);
        result     : out std_logic_vector(31 downto 0);
        zero       : out std_logic
    );
  end component;

  component regfile is
    port(
        ra1 : in  std_logic_vector(4 downto 0);
        ra2 : in  std_logic_vector(4 downto 0);
        wa3 : in  std_logic_vector(4 downto 0);
        wd3 : in  std_logic_vector(31 downto 0);
        we3 : in  std_logic;
        clk : in  std_logic;
        rd1 : out std_logic_vector(31 downto 0);
        rd2 : out std_logic_vector(31 downto 0)
    );
  end component;

  component dmem is
    port(
         clk, we:  in STD_LOGIC;
         a, wd:    in STD_LOGIC_VECTOR(31 downto 0);
         rd:       out STD_LOGIC_VECTOR(31 downto 0);
         dump:     in STD_LOGIC
     );
  end component;

  signal PCSrc, Zero : std_logic;
  signal PCJump, PCBranch, PCNext, PC_2, PC_3 : std_logic_vector(31 downto 0);
  signal Instr_2, PCPlus4, SignImm, SrcB, SrcA : std_logic_vector(31 downto 0);
  signal ALUResult, WriteData, ReadData, Result : std_logic_vector(31 downto 0);
  signal WriteReg : std_logic_vector(4 downto 0);
  -- Signal auxiliar
  signal  sl2_Adder : std_logic_vector(31 downto 0);


  begin

  PCJump <= ("00" & PCPlus4(31 downto 28) & Instr_2(25 downto 0));
  PCSrc  <= (Branch and Zero);
  PCSrc_mux  : mux2 port map(d0=>PCPlus4, d1=>PCBranch, s=>PCSrc, y=>PCNext);
  PCJump_mux : mux2 port map(d0=>PCNext, d1=>PCJump, s=>Jump, y =>PC_2);
  Flopr_0    : flopr port map(clk=>clk, reset=>reset, d=>PC_2, q=>PC_3);
  Adder_Plus : adder port map(a=>PC_3, b=>"00000000000000000000000000000001",
               y=>PCPlus4);
  Imem_0     : imem port map(a=>PC_3(5 downto 0), rd=>Instr_2);
  RegFile_0  : regfile port map(ra1=>Instr_2(25 downto 21), 
               ra2=>Instr_2(20 downto 16), wa3=>WriteReg, wd3=>Result, 
               we3=>RegWrite, clk=>clk, rd1=>SrcA, rd2=>WriteData);
  SigNext_0  : signext port map(a=>Instr_2(15 downto 0), y=>SignImm);
  RegDst_mux : mux2 generic map (NBITS => 4) 
               port map(d0=>Instr_2(20 downto 16), d1=>Instr_2(15 downto 11),
               s=>RegDst, y=>WriteReg);
  AluSrc_mux : mux2 port map(d0=>WriteData, d1=>SignImm, s=>AluSrc, y=>SrcB);
  --Sl2_0      : sl2 port map(a=>SignImm, y=>sl2_Adder);
  ALU_0      : alu port map(a=>SrcA, b=>SrcB, alucontrol=>AluControl,
               zero=>zero, result=>AluResult);
  Adder_Bran : adder port map(a=>SignImm, b=>PCPlus4, y=>PCBranch);
  Dmem_0     : dmem port map(a=>AluResult, wd=>WriteData, dump=>Dump,
               clk=>clk, we=>MemWrite, rd=>ReadData);

  MemTo_mux2 : mux2 port map(d0=>AluResult, d1=>ReadData, s=>MemToReg, y=>Result);
  
  pc <= PC_2;
  instr <= Instr_2;
end architecture;
