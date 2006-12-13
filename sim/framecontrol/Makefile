VHDLC=vhdlp
VHDLS=vhdle
WORKDIR=work.sym
all: hw comp sim

$(WORKDIR)/framecontrol/_behavioral.var: ../../vhdl/framecontrol.vhd
	$(VHDLC) ../../vhdl/framecontrol.vhd

hw: $(WORKDIR)/framecontrol/_behavioral.var 

comp: 

$(WORKDIR)/framecontroltest/_behavioral.var: framecontroltest.vhd
	$(VHDLC) framecontroltest.vhd

sim: $(WORKDIR)/framecontroltest/_behavioral.var 
runsim: all
	$(VHDLS) framecontroltest


clean:
	rm -Rf $(WORKDIR)$

