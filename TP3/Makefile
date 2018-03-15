SRC= adder.vhd aludec.vhd alu.vhd components.vhd controller.vhd datapath.vhd \
	dmem.vhd flopr.vhd imem.vhd maindec.vhd mips.vhd mux2.vhd regfile.vhd signext.vhd sl2.vhd

OBJECTS=$(SRC:.vhd=.o)

all: $(SRC)
	ghdl -a --ieee=synopsys -fexplicit $(SRC) mips_tb.vhd
	ghdl -e --ieee=synopsys -fexplicit mips_tb 


vcd: all
	ghdl -r mips_tb --vcd=mips_tb.vcd --stop-time=4000ns

%.o: %.vhd
	ghdl -a --ieee=synopsys -fexplicit $<

clean:
	rm -f *.o
	rm -f *.cf
	rm -f *.vcd
	rm -f mips_tb
