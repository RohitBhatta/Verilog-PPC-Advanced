VFILES=$(wildcard *.v)

OKFILES=$(wildcard *.ok)
TESTS=$(subst .ok,,$(OKFILES))
OUTS=$(addsuffix .out,$(TESTS))
RESULTS=$(addsuffix .res,$(TESTS))

all : ppc

VFILES = ${wildcard *.v}

ppc : ${VFILES} Makefile
	iverilog -Wall -o $@  ${VFILES}


$(OUTS) : %.out : ppc Makefile %.bin
	@#echo "\n#====== $@ ======"
	@-rm -f mem.bin ppc.vcd
	@-cp $*.bin mem.bin
	@-timeout 10 ./ppc > $*.raw 2>&1
	@-rm -f mem.bin
	@-mv ppc.vcd $*.vcd
	@-egrep -v '^WARNING' $*.raw | egrep -v '^=== ' | egrep -v '^VCD'  > $*.out
	@#echo "#=================\n"

$(RESULTS) : %.res : %.out %.ok Makefile
	@echo -n "$* ... "
	@egrep '^=== ' $*.raw | sed -e's/^===  *//'  > $*.cycles
	-@((diff -bwB $*.out $*.ok > /dev/null 2>&1) && echo "pass [`cat $*.cycles`]") || (echo "fail" )

test : $(OUTS) $(RESULTS)

clean :
	rm -rf *.raw *.out *.vcd ppc mem.bin
