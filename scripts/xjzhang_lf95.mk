###################################################
## IPP Linux cluster                             ##
## Roberto Bilato nov 2006                       ##
## Last update: feb 2007
###################################################

# ----------------------- variables  ---------------------------------- #
# 64-bit
 COMPTYPE = lf95
#COMPTYPE = ifort

# 32-bit
#COMPTYPE = f95f
#COMPTYPE = f95i

# ----------------------- Libraries & Modules ------------------------- #

SVN = /usr/bin/svn

# -- paths to libraries
PATH_LIBS=/home/xjzhang/libs_lf
LNETCDF   = ${PATH_LIBS}/ntcc_lf/lib
MNETCDF   = ${PATH_LIBS}/ntcc_lf/mod
FFTW      = ${PATH_LIBS}/ntcc_lf/lib
LI2MEX    = ${PATH_LIBS}/ntcc_lf/lib
MI2MEX    = ${PATH_LIBS}/ntcc_lf/mod
RLIB      = 
SCALAPACK = ${PATH_LIBS}/scalapack_lf
LAPACK    = ${PATH_LIBS}/scalapack_lf
BLACS     = ${PATH_LIBS}/scalapack_lf
BLAS      = ${PATH_LIBS}/scalapack_lf

#---FFTW library
EXTRA_LDFLAGS = -L${FFTW}/ -lfftw

# ---- Optionally NTCC library for numerical equilibrium -> i2mex 
ifeq ($(NTCC),yes)
   EXTRA_LDFLAGS +=  \
	-L${LI2MEX}/  -li2mex -lezcdf \
	-L${LNETCDF}/ -lnetcdf \
	-L${LI2MEX}/  -lxplasma -lnscrunch -lpspline \
                      -lesc -lmclib -lfluxav -lsmlib -lcomput -lportlib \
                      -lmdstransp -lvaxonly \
        -L${LI2MEX}/  -lmds_dummy -lgeneric_dummy -llsode -llsode_linpack 
endif


# --- NETCDF library
EXTRA_LDFLAGS += -L${LNETCDF}/ -lnetcdf



Storic: EXTRA_LDFLAGS += \
                 $(BLAS)/blas_LINUX.a               \
                 $(LAPACK)/lapack_LINUX.a             

#                 -L$(MKLLIB) -lmkl_lapack -lmkl_ia32 -Bstatic \
#                                 -lguide -Bdynamic -lpthread  

Ptoric: EXTRA_LDFLAGS += \
                 $(SCALAPACK)/libscalapack_LINUX_$(COMPTYPE).a    \
                 $(BLAS)/blas_LINUX_$(COMPTYPE).a               \
                 $(LAPACK)/lapack_LINUX_$(COMPTYPE).a             \
                 $(BLACS)/blacsF77init_MPI-LINUX-0_$(COMPTYPE).a  \
                 $(BLACS)/blacs_MPI-LINUX-0_$(COMPTYPE).a         \
                 $(BLACS)/blacsCinit_MPI-LINUX-0_$(COMPTYPE).a

#Ptoric: EXTRA_LDFLAGS += \
#                -L$(MKLLIB)  -lmkl_scalapack -lmkl_blacs  -lmkl_lapack -lmkl_ia32 \
#                                         -Bstatic  -lguide  -Bdynamic -lpthread  -lgcc \
#                 /afs/ipp/u/rbb/usr/local/@sys/$(COMPTYPE)/lib/pzlaprnt.o 


# vector math library
ifeq ($(COMPTYPE), lf95)
  # Storic: EXTRA_LDFLAGS += -lfst
endif

ifeq ($(COMPTYPE), f95i)
   EXTRA_LDFLAGS +=  -lsvml 
endif
# ---------------------------------------------------------------



# ----------------------- Compilers -------------------------------------------- #

###############################
# Compiler Preprocessor and C #
###############################
FCPP  = /pkg/lf95/8.1/lib/cpp -traditional
CCPP  = /usr/bin/cpp -undef -traditional
CC    = gcc


# Precompiler options 
CPP_FLAGS = -P -C 
CPP_FLAGS += -DNO_SLATEC             # No slatec routines -> linpkr

ifeq ($(findstring P, $(MAKECMDGOALS)),P)
  CPP_FLAGS += -DPARALLEL      # parallel
endif
#make won't invoke in this form for rules triggered by included makefiles - JCW Feb2011
#Ptoric: CPP_FLAGS += -DPARALLEL      # parallel



####################
# Fortran Compiler #
#################### 
# Lahey 
ifeq ($(COMPTYPE), lf95)
    FC = mpif90

   FREEFORM = -Free

   ifeq ($(NTCC),yes)
      CPP_FLAGS += -DLNTCC   # Added the i2mex library for numerical equilibrium
   endif

   ifeq ($(DEBUG),yes)
      FFLAGS   =  -g #-\#\#\# --chkglobal -Ad -Am -X9  -Fixed 
   else	
      FFLAGS   =   -O -Ad -Am -X9  -Fixed 
   endif

endif



# ----------------------- Building Library Commands ---------------------------- #

AR = ar 
ARFLAGS = crv
RANLIB = ranlib


#### AFTER THIS LINE NO CHANGES SHOULD BE NECESSARY.
# ----------------------- Compmon Flags --------------------------------------- #

FFLAGS   += -I${MNETCDF} -I${BINDIR}  -I${MI2MEX} 



