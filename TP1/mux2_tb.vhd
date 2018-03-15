library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2_tb is
end entity;

architecture behav of mux2_tb is
	component mux2 is
	port(   d0: in std_logic_vector(31 downto 0);
            d1: in std_logic_vector(31 downto 0);
            s: in std_logic;
            y: out std_logic_vector(31 downto 0)
        );
    end component;

    signal d0_p, d1_p, y_p : std_logic_vector(31 downto 0);
    signal s_p : std_logic;

    begin
    	mux2_0 : mux2 port map (d0=>d0_p, d1=>d1_p, s=>s_p, y=>y_p);

	    process
	    	begin
	    		d0_p <= "00000000000000000000000000000000";
	    		d1_p <= "00000000000000000000000000000001";
	    		s_p <= '0';
	    		wait for 1 ns;

	    		assert y_p = "00000000000000000000000000000001"
	    			report "Resultado erroneo" severity error;
	    		assert false report "Test end" severity note;
	   	end process;
	end;