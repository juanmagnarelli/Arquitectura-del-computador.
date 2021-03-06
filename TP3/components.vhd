library IEEE;
use IEEE.STD_LOGIC_1164.all;

package components is
  constant MIPS_SOFT_FILE: string := "/home-local/visita/Descargas/arquitectura/TP3/mips.dat";
  constant MEMORY_DUMP_FILE: string := "/home-local/visita/Descargas/arquitectura/TP3/mem.dump";

  component adder is
    port (
         a, b : in std_logic_vector(31 downto 0);
         y    : out std_logic_vector(31 downto 0)
    );
  end component;

  component aludec is
    port(
      funct      : in  std_logic_vector( 5 downto 0);
      aluop      : in  std_logic_vector( 1 downto 0);
      alucontrol : out  std_logic_vector( 2 downto 0)
    );
  end component;

  component alu is
    port(
        a          : in  std_logic_vector( 31 downto 0);
        b          : in  std_logic_vector( 31 downto 0);
        alucontrol : in  std_logic_vector( 2 downto 0);
        result     : out std_logic_vector( 31 downto 0);
        zero       : out std_logic
    );
  end component;

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

  component dmem is
    port(
        a   : in  std_logic_vector( 31 downto 0);
        wd  : in  std_logic_vector( 31 downto 0);
        clk : in  std_logic;
        we  : in  std_logic;
        rd  : out std_logic_vector( 31 downto 0)
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

  component imem is
    port(
          a : in  std_logic_vector( 5 downto 0);
          s : out std_logic_vector( 31 downto 0)
        );
  end component;

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

  component mips is
    port(
       reset : in   std_logic;
       clk   : in   std_logic;
       dump  : out  std_logic;
       instr : out  std_logic_vector(31 downto 0);
       pc    : out  std_logic_vector(31 downto 0)
    );
  end component;

  component mux2 is
    port(
        d0 : in std_logic_vector(31 downto 0);
        d1 : in std_logic_vector(31 downto 0);
        s  : in std_logic;
        y  : out std_logic_vector(31 downto 0)
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

  component signext is
    port(
        a : in  std_logic_vector( 15 downto 0);
        y : out std_logic_vector( 31 downto 0)
    );
  end component;

  component sl2 is
    port(
          a : in  std_logic_vector(31 downto 0);
          y : out std_logic_vector(31 downto 0)
    );
  end component;
end components;
