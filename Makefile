##
###################################################################
##                                                               ##
##  Makefile for RIMIiCal Package                                ##
##                                                               ##
###################################################################
##
##  RISMICALDIR  RISMiCal Distribution Directory
##  BINDIR       Hard Copies of RISMiCal Executables
##  LINKDIR      Linked Copies of RISMiCal Executables
##

#RISMICALDIR = ~/software/RISMiCal
RISMICALDIR = ~/work/Prog/rismical

SRCDIR := $(RISMICALDIR)/source
OBJDIR := $(RISMICALDIR)/object
BINDIR := $(RISMICALDIR)/bin

TARGET := $(BINDIR)/rismical.x

###################################################################
#
#   Machine dependent compile option
#
###################################################################


# PGI Compiler
#FC = pgf95
#FCFLAGS = -fastsse -O4 -Mprefetch=distance:8,nta -Minline=size:50 -mp -Mfixed -mcmodel=medium 
#LDFLAGS = -lacml -lacml_mv 

# GNU Compiler
#FC =  gfortran
#FCFLAGS = -O3 -fomit-frame-pointer -ffixed-form -Wno-argument-mismatch -std=legacy
#LDFLAGS = -lblas -llapack

# # Intel Compiler
# FC =  ifort
# FCFLAGS = -O3 -shared-intel -mcmodel=medium -fixed -assume byterecl
# FCFLAGS = -O3 -shared-intel -qopenmp -fixed  -assume byterecl
# LDFLAGS = -lblas -llapack

# Pegasus
FC = nvfortran
FCFLAGS = -fast -mp
LDFLAGS = -L/work/NORYSD22/drmaruyama/local/lib -lopenblas

#FCLD = $(FC)

###################################################################

SRCS := calxvk.f  output3d.f  readguess3d.f  cl_oz1d.f  outputvv.f  readxvk.f \
       closure3d.f  oz3d.f  readinput.f  drism.f  potential3duv.f \
       readuvdata.f  fbond3duv.f  potentialuv.f  readvvdata.f  fbonduv.f \
       potentialvv.f  rismical.f  fbondvv.f  printlogo.f  rismical1d.f \
       makewx.f  prop1duv.f  rismical3d.f  prop1dvv.f  rismicalvv.f  mdiis.f \
       prop3duv.f  rismiofile.f  setup1dvx.f  misc.f  read3duvdata.f \
       setuparraysize.f  output1d.f  readguess1d.f  uvbind3d.f \
       mathlib.f ffte.f ffto.f slatec.f extern3d.f

OBJS := $(addprefix $(OBJDIR)/,$(SRCS:.f=.o))

##################################################

all: dirs $(TARGET)

dirs:
	mkdir -p $(OBJDIR)
	mkdir -p $(BINDIR)

$(TARGET): $(OBJS)
	$(FC) $(FCFLAGS) $^ $(LDFLAGS) -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.f
	$(FC) $(FCFLAGS) -c $< -o $@

##################################################

clean:
	rm -f $(OBJDIR)/*.o
	rm -f $(TARGET)

distclean:
	rm -rf $(OBJDIR) $(BINDIR)

##################################################

.PHONY: all clean distclean dirs
