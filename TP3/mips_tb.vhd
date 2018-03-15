library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips_tb is
end entity;

architecture behav of mips_tb is
  component mips is
    port(
         reset : in   std_logic;
         clk   : in   std_logic;
         dump  : in  std_logic;
         instr : out  std_logic_vector(31 downto 0);
         pc    : out  std_logic_vector(31 downto 0)
    );
  end component;

  signal dump_p, reset_p, clk_p: std_logic;
  signal pc_p, instr_p : std_logic_vector(31 downto 0);

  begin

  mips_0 : mips port map(reset=>reset_p, clk=>clk_p, dump=>dump_p, instr=>instr_p,
       pc=>pc_p);


  process
  begin
    clk_p <= '0';
    wait for 100 ns;
    clk_p <= '1';
    wait for 100 ns;
    clk_p <= '0';
    wait for 100 ns;
    clk_p <= '1';
    wait for 100 ns;
  end process;

  process
  begin
    reset_p <= '1';
    dump_p <= '0';
    wait for 100 ns;
    
    reset_p <= '0';
    wait for 3000 ns;
    
    dump_p <= '1';
    wait for 400 ns;
  end process;
end;
