library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile_tb is
end entity;

architecture TB of regfile_tb is
    constant width : integer := 32;
component regfile is
    port(
          ra1  : in  std_logic_vector(4 downto 0);
          ra2  : in  std_logic_vector(4 downto 0);
          wa3  : in  std_logic_vector(4 downto 0);
          wd3  : in  std_logic_vector(width-1 downto 0);
          we3  : in  std_logic;
          clk  : in  std_logic;
          rd1  : out std_logic_vector(width-1 downto 0);
          rd2  : out std_logic_vector(width-1 downto 0)  
        );
end component;

signal ra1_prima, ra2_prima, wa3_prima : std_logic_vector( 4 downto 0);
signal wd3_prima, rd1_prima, rd2_prima : std_logic_vector( width-1 downto 0);
signal we3_prima, clk_prima : std_logic;

begin

regfile_0: regfile port map (ra1=>ra1_prima, ra2=>ra2_prima, wa3=>wa3_prima, wd3=>wd3_prima,
                             rd1=>rd1_prima, rd2=>rd2_prima, we3=>we3_prima, clk=>clk_prima );
  process
  begin 
    clk_prima <= '0';
    wait for 2 ns;
    clk_prima <= '1';
    wait for 2 ns;
end process;

    process begin
    ra1_prima <= "00001";
    ra2_prima <= "00010";
    wa3_prima <= "00011";
    wd3_prima <= "00000000000000000000000011110001";
    we3_prima <= '1';
    wait for 5 ns;
    
    ra1_prima <= "00011";
    wait for 5 ns;
    end process;
 end;    
