all: maindec aludec dmen regfile

maindec: maindec_tb
	ghdl -r maindec_tb --stop-time=50ns --vcd=maindec.vcd

maindec_tb: mainde maindec_tb.vhd
	ghdl -a maindec_tb.vhd
	ghdl -e maindec_tb	

mainde: maindec.vhd
	ghdl -a maindec.vhd

aludec: aludec_tb
	ghdl -r aludec_tb --stop-time=50ns --vcd=aludec.vcd

aludec_tb: alude aludec_tb.vhd
	ghdl -a aludec_tb.vhd
	ghdl -e aludec_tb	

alude: aludec.vhd
	ghdl -a aludec.vhd

dmen: dmen_tb
	ghdl -r dmen_tb --stop-time=50ns --vcd=dmen.vcd

dmen_tb: dmemo dmen_tb.vhd
	ghdl -a dmen_tb.vhd
	ghdl -e dmen_tb	

dmemo: dmen.vhd
	ghdl -a dmen.vhd

regfile: regfile_tb
	ghdl -r regfile_tb --stop-time=50ns --vcd=regfile.vcd

regfile_tb: regfil regfile_tb.vhd
	ghdl -a regfile_tb.vhd
	ghdl -e regfile_tb	

regfil: regfile.vhd
	ghdl -a regfile.vhd

clean: 
	rm -rf maindec_tb
	rm -rf aludec_tb
	rm -rf dmen_tb
	rm -rf regfile_tb
	rm -rf *.o
	rm -rf *.cf
	rm -rf *.vcd