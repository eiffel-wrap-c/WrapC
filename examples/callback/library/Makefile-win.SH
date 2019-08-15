TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I $(INDIR)$(DIR)generated_wrapped$(DIR)c$(DIR)include -I $(INDIR)$(DIR)manual_wrapped$(DIR)c$(DIR)include 
JCFLAGS = $(CFLAGS) $optimize $ccflags $(INDIR)$(DIR)generated_wrapped$(DIR)c$(DIR)src$(DIR)$*.c
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = 	ewg_callback_callback_c_glue_code.$obj callback.$obj

%.c.$obj:
	$(CC) -c $(JCFLAGS) $<

#callback.c.$obj:	
#	$(CC) -c $(JCFLAGS) $(INDIR)$(DIR)generated_wrapped$(DIR)c$(DIR)src $<

all:: standard
	$(MAKE) clean

standard:: eif_callback.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

eif_callback.lib: $(OBJECTS)
	$alib_line
#	$(MKDIR) $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
#	$(MV) $@ $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
