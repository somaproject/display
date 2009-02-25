VHDLC=vcom
VHDLS=vsim
WORKDIR=work
all: hw comp sim

$(WORKDIR)/framecontrol/behavioral.dat: $(WORKDIR)/touched ../../vhdl/framecontrol.vhd
	mkdir -p $(WORKDIR)
	$(VHDLC) ../../vhdl/framecontrol.vhd

hw: $(WORKDIR)/framecontrol/behavioral.dat 

comp: 

$(WORKDIR)/framecontroltest/behavioral.dat: $(WORKDIR)/touched framecontroltest.vhd
	mkdir -p $(WORKDIR)
	$(VHDLC) framecontroltest.vhd

sim: $(WORKDIR)/framecontroltest/behavioral.dat 
runsim: all
	$(VHDLS) framecontroltest


clean:
	rm -Rf work 

work/touched:
	vlib  work
	touch  work/touched
