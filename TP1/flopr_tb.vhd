library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flopr_tb is
end entity;

architecture TB of flopr_tb is
    constant width : integer := 32;
    component flopr
    port (
          q     :out std_logic_vector( width-1 downto 0);
          d     :in  std_logic_vector( width-1 downto 0);
          reset :in  std_logic;
          clk   :in  std_logic
         );
    end component;

    signal rst_prima, clk_prima: std_logic;
    signal q_prima, d_prima: std_logic_vector( width-1 downto 0);

begin
    dut: flopr port map     (q=>q_prima, d=>d_prima,
                             clk=>clk_prima, reset=>rst_prima);

    process
    begin
        clk_prima <= '0';
        wait for 5 ns;
        clk_prima <= '1';
        wait for 5 ns;
    end process;

    process
    begin
        rst_prima <= '1';
        wait for 10 ns;
        rst_prima <= '0';
        d_prima <= "00000000000000000000000000000011";
        wait for 10 ns;
        rst_prima <= '0';
        wait for 100 ns;
    end process;
    end;
