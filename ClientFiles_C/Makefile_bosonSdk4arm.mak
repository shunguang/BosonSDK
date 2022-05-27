#this Makefile outputs image as a static lib for <PLTF> machine

PROJ_NAME=libBosonSdk
SDIR_ROOT=/home/debian/pnt/debianEnv/pkg/BosonSDK_rev206/SDK_USER_PERMISSIONS
SDIR_PROJ=$(SDIR_ROOT)/ClientFiles_C
ODIR_OBJ=$(SDIR_ROOT)/build
ODIR_LIB=$(SDIR_ROOT)/build

FSLP_INC=$(SDIR_ROOT)/FSLP_Files/src/inc
FSLP_INC2=$(SDIR_ROOT)/FSLP_Files/src/linux
PLTF_INC=/usr/include

CXX = /usr/bin/g++

#DEBUG = -O3 -g0 -DNDEBUG
#DEBUG = -O0 -g3 -DDEBUG

DEBUG = -O3 -g0 -DNDEBUG

#include flags for building libs
CFLAGS = -Wall -static -c $(DEBUG) -DECL_STANDALONE=1 -DqDNGDebug=1 -D__xlC__=1 -DNO_FCGI_DEFINES=1 -DqDNGUseStdInt=0 -DUNIX_ENV=1 -D__LITTLE_ENDIAN__=1 -DqMacOS=0 -DqWinOS=0 -std=gnu++14 \
	-I$(SDIR_PROJ) -I$(SDIR_INC) -I$(FSLP_INC2) -I$(FSLP_INC) -I$(PLTF_INC)

TARGETFILE=$(ODIR_LIB)/$(PROJ_NAME).a

SRC_FILES := $(wildcard $(SDIR_PROJ)/*.c)
OBJ_FILES := $(patsubst $(SDIR_PROJ)/%.c,$(ODIR_OBJ)/%.o,$(SRC_FILES))

OBJS = $(OBJ_FILES)

default:  directories $(TARGETFILE)

directories:    
	mkdir -p $(ODIR_OBJ)
	mkdir -p $(ODIR_LIB)

#the output lib file name is <$(TARGETFILE)>
$(TARGETFILE) : $(OBJS)
	ar rcs $(TARGETFILE) $(OBJS)

$(ODIR_OBJ)/%.o: $(SDIR_PROJ)/%.c
	$(CXX) $(CFLAGS) -c -o  $@ $<

clean:
	\rm -r $(ODIR_OBJ)/*.o $(TARGETFILE)


